{{/*
Common pod spec
*/}}
{{- define "podspec" -}}
{{- $type := .Values.type -}}
metadata:
  name: {{ template "fullname" . }}-{{ .Values.type }}
  labels:
    app: {{ template "name" . }}
    chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
    release: {{ .Release.Name }}
    heritage: {{ .Release.Service }}
    type: {{ .Values.type }}
spec:
  restartPolicy: {{ .Values.restartPolicy | default "Always" }}
  containers:
  - name: {{ .Chart.Name }}
    image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
    imagePullPolicy: {{ .Values.image.pullPolicy }}
    env:
    {{- range $key, $value := .Values.args }}
    - name: {{ $key  | upper }}
      value: {{ $value | quote }}
    {{- end }}
    {{- range $key, $value := index .Values $type }}
    - name: {{ $key  | upper }}
      value: {{ $value | quote }}
    {{- end }}
    command:
    - /usr/bin/sysbench
    - {{ .Values.type }}
    - run
    args:
    {{- range $key, $value := .Values.args }}
    - --{{ $key  | replace "_" "-" }}=$({{ $key | upper }})
    {{- end }}
    {{- range $key, $value := index .Values $type }}
    - --{{ $key  | replace "_" "-" }}=$({{ $key | upper }})
    {{- end }}
    resources:
{{ toYaml .Values.resources | indent 6 }}
{{- if .Values.nodeSelector }}
  nodeSelector:
{{ toYaml .Values.nodeSelector | indent 4 }}
    {{ end }}
{{- end -}}
