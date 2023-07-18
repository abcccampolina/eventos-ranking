class String
  def currency_to_number
    delimiter = I18n::t('number.format.delimiter')
    separator = I18n::t('number.format.separator')
    self.remove(I18n::t('number.currency.format.unit')).gsub(/[#{delimiter}#{separator}]/, delimiter => '', separator => '.').to_f
  end
  
  def normalize()
    protect_normalize()
  end

  def normalize!()
    protect_normalize(true)
  end

  protected
  def protect_normalize(by_self=false)
    str = by_self ? self : self.clone
    accents = {
      %w(á à â ä ã) => 'a',
      %w(Ã Ä Â À) => 'A',
      %w(é è ê ë) => 'e',
      %w(Ë É È Ê) => 'E',
      %w(í ì î ï) => 'i',
      %w(Î Ì) => 'I',
      %w(ó ò ô ö õ) => 'o',
      %w(Õ Ö Ô Ò Ó) => 'O',
      %w(ú ù û ü) => 'u',
      %w(Ú Û Ù Ü) => 'U',
      %w(ç) => 'c', %w(Ç) => 'C',
      %w(ñ) => 'n', %w(Ñ) => 'N'
    }
    accents.each do |ac,rep|
      ac.each do |s|
        str.gsub!(s, rep)
      end
    end
    str.gsub!(/[^a-zA-Z0-9\. ]/,"")
    str.gsub!(/[ ]+/," ")
    # str.gsub!(/ /,"-")
    #str = str.downcase
  end
end