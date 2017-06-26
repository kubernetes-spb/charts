{{/*
Init container spec
*/}}
{{- define "init_container" -}}
{{- $type := .Values.type -}}
- name: init-sysbench
  image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  workingDir: {{ default "/" .Values.workingDir }}
  command:
  - /usr/bin/sysbench
  - {{ .Values.type }}
  - prepare
  args:
  {{- range $key, $value := index .Values.init_containers $type }}
  - --{{ $key  | replace "_" "-" }}={{ $value }}
  {{- end }}
{{- if eq .Values.type "fileio" }}
  volumeMounts:
  - name: workdir
    mountPath: {{ .Values.workingDir }}
{{- end }}

{{- end -}}
