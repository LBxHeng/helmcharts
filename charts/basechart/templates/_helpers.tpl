# templates/_helpers.tpl

{{/*
Create the name of the service account to use
*/}}
{{- define "basechart.serviceAccountName" -}}
{{- if .Values.basechart.serviceAccount.create }}
{{- default (include "basechart.fullname" .) .Values.basechart.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.basechart.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "basechart.labels" -}}
helm.sh/chart: {{ include "basechart.chart" . }}
{{ include "basechart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "basechart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "basechart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create chart name and version as used by the chart label
*/}}
{{- define "basechart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the name of the chart
*/}}
{{- define "basechart.name" -}}
{{- default .Chart.Name .Values.basechart.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name
*/}}
{{- define "basechart.fullname" -}}
{{- if .Values.basechart.fullnameOverride }}
{{- .Values.basechart.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.basechart.nameOverride }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}