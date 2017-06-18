require 'spec_helper'

describe 'authors index', type: :feature, js: true do

  before do
    Author.create!(name: 'John', last_name: 'Doe')
    Author.create!(name: 'Jane', last_name: 'Roe')
    add_author_resource
    add_post_resource
  end

  context 'left-sidebar with default settings' do
    before do
      visit '/admin/authors'
    end

    it 'has left-sidebar with colapse-button' do
      expect(page).to have_css('#filters_sidebar_section')
      expect(page).to have_css('#filters_sidebar_section .collapse_btn.icono-caret-left')
      expect(page).to have_css('#active_admin_content.with_sidebar.left_sidebar.collapsible_sidebar')
    end

    context 'when click on Collapse' do
      before do
        page.find('#filters_sidebar_section .collapse_btn').click
      end

      it "sidebar is hidden, and save it's state after going to another page" do
        expect(page).to have_css('#sidebar', visible: :hidden)

        # Posts page is configured as: "before_action :skip_sidebar!"
        visit '/admin/posts'
        # sidebar does not exists at all
        expect(page).to have_css('#page_title', text: 'Posts')
        expect(page).not_to have_css('#sidebar', visible: :all)

        visit '/admin/authors'
        # sidebar is hidden
        expect(page).to have_css('#page_title', text: 'Authors')
        expect(page).to have_css('#sidebar', visible: :hidden)

        page.find('.uncollapse_btn').click

        # sidebar is visible
        expect(page).to have_css('#sidebar', visible: :visible)
        expect(page).to have_css('.collapse_btn')
        expect(page).not_to have_css('.uncollapse_btn')
      end
    end

  end

end
