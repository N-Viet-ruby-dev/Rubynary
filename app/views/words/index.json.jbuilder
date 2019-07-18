# frozen_string_literal: true


json.words do
  json.array!(@words) do |word|
    if language == "en_cont"
      json.value word.en
    elsif language == "vi_cont"
      json.value word.vi
    else
      json.value word.ja
    end
  end
end

# json.words do
#   json.array!(@words.map { |word| [word.ja, word.en, word.vi] }.sum) do |value|
#     json.value value
#   end
# end



# json.words do
#   json.array!(@words) do |word|
#     if params[:lg] == "en_cont"
#       json.value word.en
#     end
#     if params[:lg] == "vi_cont"
#       json.value word.vi
#     end
#     # json.en word.en
#     # json.vi word.vi
#   end
# end

