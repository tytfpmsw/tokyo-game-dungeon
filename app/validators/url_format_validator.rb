class UrlFormatValidator < ActiveModel::EachValidator

  VALID_URL_REGEX = /\A#{URI::regexp(%w(http https))}\z/

  def validate_each(record, attribute, value)
    # 必須にしたい場合は呼び出し側でpresecence: trueを指定する
    return if value.blank?

    unless value =~ VALID_URL_REGEX
      record.errors.add(attribute, 'は正しいURL形式で入力してください')
    end
  end
end