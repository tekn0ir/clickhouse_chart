{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "clickhouse.name" -}}
{{- printf "%s" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a proper ingress name.
*/}}
{{- define "clickhouse.ingress_host" -}}
{{- printf "%s.%s" .Release.Name .Values.ingress.host_postfix -}}
{{- end -}}

{{/*
Create a init db query
*/}}
{{- define "clickhouse.init_query" -}}
{{- printf "%s" (.Files.Get "conf/initdb.sql") -}}
{{- end -}}

{*{{/**}
{*Create a bas64 encoded secrets.*}
{**/}}*}
{*{{- define "clickhouse.image_pull_secret" }}*}
{*{{- $auth := printf "%s:%s" .Values.imagePullCredentials.username .Values.imagePullCredentials.password | b64enc }}*}
{*{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\", \"email\": \"%s\"}}}" .Values.imagePullCredentials.registry $auth .Values.imagePullCredentials.email | b64enc }}*}
{*{{- end }}*}

{*{{- define "clickhouse.image_pull_secret_name" }}*}
{*{{- $name := default .Chart.Name .Values.nameOverride -}}*}
{*{{- printf "%s-%s-pull-secret" .Release.Name $name }}*}
{*{{- end }}*}

{*{{- define "clickhouse.kafka_secret_name" }}*}
{*{{- $name := default .Chart.Name .Values.nameOverride -}}*}
{*{{- printf "%s-%s-kafka-secret" .Release.Name $name }}*}
{*{{- end }}*}

{*{{- define "clickhouse.kafka_secret_content" }}*}
{*{{- $username := printf "username=\"%s\"" .Values.kafkaCredentials.username }}*}
{*{{- $password := printf "password=\"%s\"" .Values.kafkaCredentials.password }}*}
{*{{- printf "KafkaClient { org.apache.kafka.common.security.plain.PlainLoginModule required %s %s; };" $username $password | b64enc }}*}
{*{{- end }}*}

{*{{- define "clickhouse.tls_certificate" }}*}
{*{{- printf "%s" .Values.tlsSecret.certificate | b64enc }}*}
{*{{- end }}*}

{*{{- define "clickhouse.tls_key" }}*}
{*{{- printf "%s" .Values.tlsSecret.key | b64enc }}*}
{*{{- end }}*}

{*{{- define "clickhouse.tls_certificate_secret_name" }}*}
{*{{- printf "%s-tls-certificate-secret" .Release.Name }}*}
{*{{- end }}*}