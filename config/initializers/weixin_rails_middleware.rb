# encoding: utf-8
# Use this hook to configure WeixinRailsMiddleware bahaviors.
WeixinRailsMiddleware.configure do |config|

  ## NOTE:
  ## If you config all them, it will use `weixin_token_string` default

  ## Config public_account_class if you SAVE public_account into database ##
  # Th first configure is fit for your weixin public_account is saved in database.
  # +public_account_class+ The class name that to save your public_account
  # config.public_account_class = "PublicAccount"

  ## Here configure is for you DON'T WANT TO SAVE your public account into database ##
  # Or the other configure is fit for only one weixin public_account
  # If you config `weixin_token_string`, so it will directly use it
  config.weixin_token_string = '71f72bcb9f99bfb2a6635c30'
  # using to weixin server url to validate the token can be trusted.
  config.weixin_secret_string = '67b21dc39ca1e6a46a2551d7589d3c1c'
  # 加密配置，如果需要加密，配置以下参数
  config.encoding_aes_key = 'hOnUkWRwbXnJKb8k7ncVA5Ck3DmQRgS47LIc60iEaDV'
  # config.encoding_aes_key = 'd010cec4569bb962602871a6731ad089'
  config.app_id = "wxcd581a346bffaf2d"

  ## You can custom your adapter to validate your weixin account ##
  # Wiki https://github.com/lanrion/weixin_rails_middleware/wiki/Custom-Adapter
  # config.custom_adapter = "MyCustomAdapter"

end

$client ||= WeixinAuthorize::Client.new(WeixinRailsMiddleware.config.app_id, WeixinRailsMiddleware.config.weixin_secret_string)