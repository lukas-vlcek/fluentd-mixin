{
  _config+:: {

    // Fluentd health alert
    // ====================
    //
    // If Prometheus could not scrape fluentd instance for more than fluentdHealthRED minutes,
    // raise critical alert.

    fluentdHealthRED: '10m',

    // Fluentd overwhelmed alert
    // =========================
    //
    // If Fluentd buffer queue length is increased more than fluentdIncreasedQLength in 1 minute,
    // raise warning alert.

    fluentdIncreasedQLength: 32,

    // Fluentd overloaded alert
    // ========================
    //
    // If Fluentd buffer queue length is constantly increased for more than fluentdQGrowingTime,
    // raise critical alert.

    fluentdQGrowingTime: '12h',

    // Fluentd high error counts
    // =========================
    //
    // If Fluentd issues more than fluentdNumErrors, raise critical alert.

    fluentdNumErrors: 10,
  },
}
