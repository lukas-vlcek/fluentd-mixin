local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;

{
  grafanaDashboards+:: {
    'fluentd.json':
      dashboard.new('Fluentd', time_from='now-3h'),
  },
}
