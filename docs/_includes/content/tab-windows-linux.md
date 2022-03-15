{% if include.head %}
<ul class="nav nav-tabs">
  <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#WindowsId1" role="tab" >Windows</a></li>
  <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#LinuxId1" role="tab">Linux</a></li>
</ul>
<div class="tab-content">
  <div class="tab-pane fade in active" id="WindowsId1" role="tabpanel" markdown="1">
{% endif %}
{% if include.middle %}
  </div>
  <div class="tab-pane fade in" id="LinuxId1" role="tabpanel" markdown="1">
{% endif %}
{% if include.foot %}
  </div>
</div> <!-- tab-content -->
{% endif %}
