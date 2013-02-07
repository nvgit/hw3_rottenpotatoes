# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    #Movie.find_by_title_and_rating(movie[:title], movie[:rating]).inspect
    if !Movie.find_by_title_and_rating(movie[:title], movie[:rating]) then
      Movie.create!(movie)
    end
  end
  assert (Movie.count >= movies_table.hashes.count), "Error while DB filling"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body.index(e1) < page.body.index(e2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split.each do |rating|
    if uncheck then
      step %{I uncheck "ratings[#{rating}]"}
    else
      step %{I check "ratings[#{rating}]"}
    end
  end
end

Then /^I should see all of the movies$/ do
  page.all('table#movies tr').count.should == Movie.all.count + 1
end

Then /^I should not see any of the movies$/ do
  page.all('table#movies tr').count.should == Movie.all.count + 1
end
