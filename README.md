# promdate

Promdate is a simple Web service which acts as a bridge between the Prometheus Operator's ServiceMonitor objects, and external sites which normally can't be represented by a ServiceMonitor. Simply pass the URL, minus the scheme/protocol, to ServiceMonitor in its `path` property, and the proxy will fetch the contents of that URL and return it.

For instance, if Promdate is hosted at `http://promdate.local`, then this URL:

`http://promdate.local/www.acme.com/metrics/` will return the contents of `https://www.acme.com/metrics`
