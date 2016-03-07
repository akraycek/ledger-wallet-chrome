class @Output extends ledger.database.Model
  do @init

  @index 'uid'

  ###
    {
       "output_index": 0,
        "value": 1000000,
        "addresses": [
          "18VLgzpLjLMRB8udaSrs4ha8gwzjzVgHUT"
        ],
        "script_hex": "76a9145224f6a5cbfa97dbe098bd72c1813c60982ff04e88ac"
    }
  ###
  @fromJson: (transactionHash, output, context = ledger.database.contexts.main) ->
    uid = "#{transactionHash}_#{output['output_index']}"
    base =
      uid: uid
      transaction_hash: transactionHash
      index: output['output_index']
      value: output['value']
      address: output['addresses'][0]
      path: ledger.wallet.Wallet.instance.cache.getDerivationPath(output['addresses'][0])
      script_hex: output['script_hex']
    @findOrCreate(uid: uid, base, context)

  @utxo: (context = ledger.database.contexts.main) ->
    output for output in @find(path: {$ne: undefined}, context).data() when _.isEmpty(Input.find(uid: output.get('uid'), context).data())