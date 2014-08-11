require 'spec_helper'

describe 'User is not logged in', :type => :feature do
  subject { page }

  let(:person) { create(:person) }

  context 'the home page' do

    before do
      visit root_path
    end

    it 'should have the greeting' do
      expect(page).to have_content 'Find other Rails Girls students, coaches and project groups!'
    end
  end

  context 'the groups page' do

    before do
      visit root_path
      click_link 'Groups'
    end

    it 'should have a list of groups' do
      expect(page).to have_content 'Groups overview'
    end
  end

  context 'a group detail page' do

    # added activities otherwise the markdown field receives a value of 'nil'
    # and the test fails
    let!(:group) { create(:group, founded_on: Date.today, activities: 'stuff') }

    before do
      visit '/groups/1'
    end

    it 'should show some group info' do
      expect(page).to have_content 'Founded'
    end
  end

  context 'the people page' do

    before do
      visit root_path
      click_link 'People'
    end

    it 'should show a list of people' do
      expect(page).to have_content 'People overview'
    end
  end

  context 'a person\'s detail page' do

    let(:person) { create(:person) }

    before do
      visit '/people/1'
    end

    it 'should redirect to sign in' do
      expect(page).to have_content 'You need to sign in'
    end
  end

  context 'the blog' do

    before do
      visit root_path
      click_link 'Blog'
    end

    it 'should show the blog header' do
      expect(page).to have_content 'Corporate Blog'
    end
  end
end
