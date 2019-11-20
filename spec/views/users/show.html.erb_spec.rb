# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :view do
  pending "add some examples to (or delete) #{__FILE__}"
end
#   let(:user) { User.first }
#   context 'when user is signed in' do
#     before do
#       # mock current_user
#       allow(view).to receive(:current_user).and_return(user)
#     end
#
#     it 'shows edit link' do
#       render
#
#       expect(rendered).to have_css('#name', text: user.name)
#
#       assert_select 'table' do
#         assert 'tr:nth-child(1)' do
#           assert_select 'td:nth-child(1)', "#{@posts.first.title}"
#           assert_select "#edit-post-#{@posts.first.id}", 'Edit'
#         end
#
#         assert 'tr:nth-child(2)' do
#           assert_select 'td:nth-child(1)', "#{@posts.second.title}"
#           assert_select "#edit-post-#{@posts.second.id}", 'Edit'
#         end
#       end
#     end
#   end
# end
