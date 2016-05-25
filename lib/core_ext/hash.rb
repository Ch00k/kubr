require 'active_support'
require 'active_support/core_ext'


class Hash
  def recursively_symbolize_keys!
    symbolize_keys!
    values.each { |h| h.recursively_symbolize_keys! if h.is_a?(Hash) }
    values.select { |v| v.is_a?(Array) }.flatten.each{|h| h.recursively_symbolize_keys! if h.is_a?(Hash) }
    self
  end
end
