{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'logging_fluentd.alerts',
        rules: [
          {
            alert: 'FluentdNodeDown',
            expr: |||
              absent(up{job="fluentd"} == 1)
            |||,
            'for': '%(fluentdHealthRED)s' % $._config,
            labels: {
              service: 'fluentd',
              severity: 'critical',
            },
            annotations: {
              summary: 'Fluentd cannot be scraped',
              message: 'Prometheus could not scrape fluentd {{ $labels.instance }} for more than %(fluentdHealthRED)s.' % $._config,
            },
          },
          {
            alert: 'FluentdQueueLengthBurst',
            expr: |||
              delta(fluentd_output_status_buffer_queue_length[1m]) > %(fluentdIncreasedQLength)s
            ||| % $._config,
            'for': '1m',
            labels: {
              service: 'fluentd',
              severity: 'warning',
            },
            annotations: {
              summary: 'Fluentd is overwhelmed',
              message: 'In the last minute, fluentd {{ $labels.instance }} buffer queue length increased more than %(fluentdIncreasedQLength)s. Current value is {{ $value }}.' % $._config,
            },
          },
          {
            alert: 'FluentdQueueLengthIncreasing',
            expr: |||
              delta(fluentd_output_status_buffer_queue_length[1m]) > 1
            |||,
            'for': '%(fluentdQGrowingTime)s' % $._config,
            labels: {
              service: 'fluentd',
              severity: 'critical',
            },
            annotations: {
              summary: 'Fluentd file buffer usage issue',
              message: 'In the last %(fluentdQGrowingTime)s, fluentd {{ $labels.instance }} buffer queue length constantly increased more than 1. Current value is {{ $value }}.' % $._config,
            },
          },
          {
            alert: 'FluentdErrorsHigh',
            expr: |||
              fluentd_output_status_num_errors > %(fluentdNumErrors)s
            ||| % $._config,
            'for': '1m',
            labels: {
              service: 'fluentd',
              severity: 'critical',
            },
            annotations: {
              summary: 'Fluentd reports high number of errors',
              message: 'In the last minute, {{ $value }} errors reported by fluentd {{ $labels.instance }}.',
            },
          },
        ],
      },
    ],
  },
}
