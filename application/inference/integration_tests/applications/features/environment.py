import pybreaker

# See circuit breaker pattern: https://martinfowler.com/bliki/CircuitBreaker.html handling timeouts and issues with remote calls
circuit_breaker = pybreaker.CircuitBreaker(fail_max=3, reset_timeout=20)

def before_feature(context, feature):
    if "skip" in feature.tags:
        feature.skip("Marked with @skip, since this feature is work in progress")
        return

def before_scenario(context, scenario):
    if "skip" in scenario.effective_tags:
        scenario.skip("Marked with @skip, since this scenario is work in progress")
        return