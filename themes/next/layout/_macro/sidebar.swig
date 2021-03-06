{% macro render(is_post) %}
  <div class="sidebar-toggle">
    <div class="sidebar-toggle-line-wrap">
      <span class="sidebar-toggle-line sidebar-toggle-line-first"></span>
      <span class="sidebar-toggle-line sidebar-toggle-line-middle"></span>
      <span class="sidebar-toggle-line sidebar-toggle-line-last"></span>
    </div>
  </div>

  <aside id="sidebar" class="sidebar">
    {% if theme.sidebar.onmobile %}
      <div id="sidebar-dimmer"></div>
    {% endif %}
    <div class="sidebar-inner">

      {% if page.toc_number === undefine %}
        {% set toc = toc(page.content, { "class": "nav", list_number: theme.toc.number }) %}
      {% else %}
        {% set toc = toc(page.content, {"class": "nav", list_number: page.toc_number}) %}
      {% endif %}

      {% set display_toc = is_post and theme.toc.enable and toc.length > 1 %}

      {% if display_toc %}
        <ul class="sidebar-nav motion-element">
          <li class="sidebar-nav-toc sidebar-nav-active" data-target="post-toc-wrap" >
            {{ __('sidebar.toc') }}
          </li>
          <li class="sidebar-nav-overview" data-target="site-overview">
            {{ __('sidebar.overview') }}
          </li>
        </ul>
      {% endif %}

      <section class="site-overview sidebar-panel {% if not display_toc %} sidebar-panel-active {% endif %}">

        <div class="site-author motion-element" itemprop="author" itemscope itemtype="http://schema.org/Person">
          <img class="site-author-image" itemprop="image"
               src="{{ theme.avatar or url_for(theme.images) + '/default_avatar.jpg' }}"
               alt="{{ theme.author }}" />
          <p class="site-author-name" itemprop="name">{{ theme.nick_name }}</p>
          <p class="site-description motion-element" itemprop="description">{{ theme.signature }}</p>
        </div>

        <nav class="site-state motion-element">
          <div class="site-state-item site-state-posts">
            <a href="{{ url_for(theme.menu.archives) }}">
              <span class="site-state-item-count">{{ site.posts.length }}</span>
              <span class="site-state-item-name">{{ __('state.posts') }}</span>
            </a>
          </div>

          {% if site.categories.length > 0 %}
            <div class="site-state-item site-state-categories">
              <a href="{{ url_for('/archives') }}">
                <span class="site-state-item-count">{{ site.categories.length }}</span>
                <span class="site-state-item-name">{{ __('state.categories') }}</span>
              </a>
            </div>
          {% endif %}

          {% if site.tags.length > 0 %}
            <div class="site-state-item site-state-tags">
              <a href="{{ url_for('/tags') }}">
                <span class="site-state-item-count">{{ site.tags.length }}</span>
                <span class="site-state-item-name">{{ __('state.tags') }}</span>
              </a>
            </div>
          {% endif %}

          <div class="site-state-item site-state-messages">
            <a href="{{ url_for('/messages') }}">
              <span class="site-state-item-count">0</span>
              <span class="site-state-item-name">{{ __('state.messages') }}</span>
            </a>
          </div>
          
          <script type="text/javascript">
            function loadMessageCount() {
              $.ajax({
                url: "https://www.liuwj.me/api/comments/stats",
                type: "get",
                dataType: "json",
                async: true,
                success: function(rsp) {
                  $(".site-state-messages .site-state-item-count").html(rsp.stats.sum)
                }
              });
            }

            if (window.attachEvent) {
              window.attachEvent("onload", loadMessageCount);
            } else if (window.addEventListener) {
              window.addEventListener("load", loadMessageCount, false);
            }
          </script>

        </nav>

        {% if theme.rss %}
          <div class="feed-link motion-element">
            <a href="{{ url_for(theme.rss) }}" rel="alternate" target="_blank">
              <i class="fa fa-rss"></i>
              RSS
            </a>
          </div>
        {% endif %}

        <div class="links-of-author motion-element">
          {% if theme.social %}
            {% for name, link in theme.social %}
              <span class="links-of-author-item">
                <a href="{{ link }}" {% if name !== "Email" %}target="_blank"{% endif %} title="{{ name }}">
                  {% if theme.social_icons.enable %}
                    <i class="fa fa-fw fa-{{ theme.social_icons[name] | default('globe') | lower }}"></i>
                  {% endif %}
                  {{ name }}
                </a>
              </span>
            {% endfor %}
          {% endif %}
        </div>

        {% set cc = {'by': 1, 'by-nc': 1, 'by-nc-nd': 1, 'by-nc-sa': 1, 'by-nd': 1, 'by-sa': 1, 'zero': 1} %}
        {% if theme.creative_commons.license in cc %}
          <div class="cc-license motion-element" itemprop="license">
            <a href="https://creativecommons.org/{% if theme.creative_commons.license === 'zero' %}publicdomain/zero/1.0{% else %}licenses/{{ theme.creative_commons.license }}/4.0{% endif %}/" class="cc-opacity" target="_blank" title="{{ theme.creative_commons.notice_text }}">
              <!--<img src="https://i.creativecommons.org/l/{{ theme.creative_commons.license }}/4.0/88x31.png" alt="Creative Commons" />-->
              <img src="{{ url_for(theme.images) }}/cc-{{ theme.creative_commons.license }}-88x31.png" alt="Creative Commons" />
            </a>
          </div>
        {% endif %}

        {# Blogroll #}
        <div class="links-of-blogroll motion-element">
          {% if theme.links %}
            <div class="links-of-blogroll-title">{{ theme.links_title }}</div>
            <ul class="links-of-blogroll-list">
              {% for name, link in theme.links %}
                <li class="links-of-blogroll-item">
                  <a href="{{ link }}" target="_blank">{{ name }}</a>
                </li>
              {% endfor %}
            </ul>
          {% endif %}
        </div>

      </section>

      {% if display_toc %}
        <section class="post-toc-wrap motion-element sidebar-panel sidebar-panel-active">
          <div class="post-toc">
            {% if toc.length <= 1 %}
              <p class="post-toc-empty">{{ __('post.toc_empty') }}</p>
            {% else %}
              <div class="post-toc-content">{{ toc }}</div>
            {% endif %}
          </div>
        </section>
      {% endif %}

    </div>
  </aside>
{% endmacro %}