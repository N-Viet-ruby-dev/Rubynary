# frozen_string_literal: true

json.words do
  json.array!(@words.map { |word| [word.ja, word.en, word.vi] }.sum) do |value|
    json.value value
  end
end
