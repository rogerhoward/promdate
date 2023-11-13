# promdate

Promdate is a simple Web service which acts as a bridge between the Prometheus Operator's ServiceMonitor objects, and external sites which normally can't be represented by a ServiceMonitor. Simply pass the URL, minus the scheme/protocol, to ServiceMonitor in its `path` property, and the proxy will fetch the contents of that URL and return it.

For instance, if Promdate is hosted at `http://promdate.local`, then this URL:

`http://promdate.local/www.acme.com/metrics/` will return the contents of `https://www.acme.com/metrics`

## getting started

### requirements

1. a working Kubernetes cluster
2. a working Prometheus environment in Kubernetes, with the [Prometheus Operator and CRDs](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/user-guides/getting-started.md) installed
3. a site with a metrics exporter that is reachable by http/https

### deploy Promdate

You may only need one instance of Promdate per cluster, but I'll leave that to you. 

The important bits involved are:

- host the [promdate container](https://hub.docker.com/r/rogerhoward/promdate/) and expose it via a Service object. This project provides an [example using a simple Deployment and a Service](k8s/promdate.yaml)

### use Promdate

- create one or more Prometheus ServiceMonitor objects that point at the Service. This project provides an [example ServiceMonitor object](k8s/servicemonitor.yaml)
