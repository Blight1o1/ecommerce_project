Rails.configuration.stripe = {
    publishable_key: ENV['PUBLISHABLE_KEY'],#'pk_test_51JtzxFIlgad10wjRDAWuJnxadHGxISRksM8Su5GIf8ZhlKX4gSeUccVkU1faxGniROYCECWCZzQMCS9FQG14aku900OHv9EcUj'],
    secret_key: ENV['SECRET_KEY']#'sk_test_51JtzxFIlgad10wjRk4OJUKeKHuPpgV8B1h3YY4D9AdYzxAk4ELhQmvnU0usXmZPKMf64GLncMpOLfA64xWzWQ2DY00Taoxj6d2']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]