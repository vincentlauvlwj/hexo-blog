{% if theme.use_https %}
  <!-- 站内所有 HTTP 资源，一律替换为 HTTPS -->
  <!-- <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests"> -->
  <!-- 协议降级，跳转到非 HTTPS 的站点时，仍然携带 referrer 请求头 -->
  <meta name="referrer" content="always" />
{% endif %}

<meta charset="UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width,user-scalable=no,initial-scale=1,minimum-scale=1,maximum-scale=1">

{# Disable transformation #}
<meta http-equiv="Cache-Control" content="no-transform" />
<meta http-equiv="Cache-Control" content="no-siteapp" />

{# Website description #}
{% if page.description %}
  <meta name="description" content="{{ page.description }}"/>
{% elif page.title %}
  <meta name="description" content="{{ page.title }}"/>
{% elif config.description %}
  <meta name="description" content="{{ config.description }}"/>
{% endif %}

{# Website keywords #}
{% if page.keywords %}
  <meta name="keywords" content="{{ page.keywords }}" />
{% elif page.tags and page.tags.length %}
  <meta name="keywords" content="{% for tag in page.tags %}{{ tag.name }},{% endfor %}" />
{% endif %}
