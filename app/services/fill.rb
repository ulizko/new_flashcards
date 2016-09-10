class Fill
  def self.start(options)
    page = Nokogiri::HTML(open(options[:url]).read)
    original_text = page.xpath(options[:original_text_selector]).map(&:text)
    translated_text = page.xpath(options[:translated_text_selector]).map(&:text)
    original_text.zip(translated_text).map { |v| [:original_text, :translated_text].zip(v).to_h }
  end
end

# e.g.: {url: 'http://sanstv.ru/english_words', original_text_selector: '//table[@id="table"]/tbody/tr/td[4]/a[2]', translated_text_selector: '//table[@id="table"]/tbody/tr/td[6]'}
