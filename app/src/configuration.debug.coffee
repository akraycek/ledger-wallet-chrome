@ledger.env = "dev"
@ledger.isProd = ledger.env == "prod"
@ledger.isDev = ledger.env == "dev"

@ledger.config ?= {}
_.extend @ledger.config,
  m2fa:
    baseUrl: 'ws://ws02.api.ledgerwallet.com/2fa/channels'
  restClient:
    baseUrl: 'https://api02.ledgerwallet.com/'
  syncRestClient:
    pullIntervalDelay: 10000
    pullThrottleDelay: 1000
    pushDebounceDelay: 1000

@configureApplication = (app) ->
  chrome.commands.onCommand.addListener (command) =>
    switch command
      when 'reload-page' then do app.reloadUi
      when 'reload-application' then do app.reload