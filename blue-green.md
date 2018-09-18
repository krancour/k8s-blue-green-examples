Outline:

# Pre-requisite vocabulary

We require, among ourselves, a common understanding of what constitutes a "release."

Twelve-Factor provides a convenient definition we can reuse: A build of your software + configuration == release.

# What is a blue/green deployment?

A blue/green deployment...

  * Is a deployment pattern that reduces downtime and risk.
  * Utilizes two identical environments to (temporarily) host two different releases\* of your software in parallel.
  * Enables controlled traffic shifting from the current release to the next. This could include:
    * User acceptance testing of the new release _before_ allowing the new release to receive any traffic.
    * Gradual (or sudden) shift of live traffic from one release to the next.
  * Enables easy roll-back if deployment of the next release fails.

# What is a "canary" deployment...

A canary deployment...

  * Is a special case of a blue/green deployment.
  * Utilizes a smaller scale deployment of the new release.

# General approach

* Conceptually, imagine two separate environments exist-- each capable of hosting a release.
  * One is colloquially known as "blue"; the other, as "green." Which is which is actually inconsequential.
  * At the start of a deployment, one environment is in use. The other is vacant.
* Deploy the new release to the vacant environment.
* Optionally conduct user acceptance testing.
* Shift live traffic from one environment to the other.
* "Undeploy" the old release.

# There's nothing new under the sun

These are not new ideas...

... but Kubernetes enables these patterns with relative ease.

# Relative ease?

Kubernetes does not _natively_ support blue/green deployments.

Kubernetes native deployment semantics (using `Deployment` resource)...
  * Effect "dumb" rolling-replacement of all application replicas (pods).
  * Are quite tunable, but do _not_ provide option to facilitate:
    * User acceptance testing
    * Controller traffic shifting

But there's nothing to stop us from using _two_ `Deployment`s.

# General approach... as supported by Kubernetes

* Have enough resources in your cluster to support what you're about to do!
* Create a new `Deployment` in parallel with the old one.
* Edit in-cluster traffic routes.
  * This is an implementation detail that varies by specific approach.
  * Optionally create specific routes to facilitate user acceptance testing.
  * Shift live traffic from one `Deployment`'s pods to the other.
* Delete the old `Deployment`

# A million ways to skin a cat

Tonight, we'll demonstrate three different implementations of the blue/green deployment pattern in a Kuberntes cluster.

These demos with, respectively:

1. Use only "out of the box" Kubernetes resources.
2. Optimize edits to in-cluster traffic routing using Istio.
3. Use Knative Serving to automate the _entire_ blue/green deployment process.

# Blue/green deployments with "out of the box" resources

## The approach

* Create a new `Deployment` in parallel with the old one.
* Optionally create a new `Service` to facilitate user acceptance testing.
  * Select pod(s) from new `Deployment`.
* Edit _existing_ `Service`.
  * Select pod(s) from new `Deployment`.
* Delete the old `Deployment`

# Blue/green deployments with Istio

## What is Istio?

## The approach

* Create a new `Deployment` in parallel with the old one.
* Optionally create a new `VirtualService` to facilitate user acceptance testing.
  * Select pod(s) from new `Deployment`.
* Edit _existing_ `VirtualService`.
  * Select pod(s) from new `Deployment`.
  * Shift traffic gradually-- or all at once.
* Delete the old `Deployment`

## The gotchas

# Blue/green deployments with Knative

## What is Knative

## The approach

* Forget managing `Deployment`s yourself!
  * Use mutable Knative `Configuration`s. `Configuration`s manage a succession of _immutable_ `Release`s. `Release`s manage `Deployment`s _for you_.
* Forget managing `Service`s or Istio `VirtualService`s yourself!
  * Use Knative `Route`s. `Route`s abstract and manage Istio resources _for you_.
* Edit your `Configuration`.
  * Watch your release get deployed!
* Optionally create "named routes" targeting the new `Release` to facilitate user acceptance testing.
* Edit `Route` to shift traffic.
  * Target the new `Release`.
  * Shift traffic gradually-- or all at once.
* Watch Knative automatically scale your old `Release` down and your new `Release` up as traffic shifts!

## The gotchas

# Thank you