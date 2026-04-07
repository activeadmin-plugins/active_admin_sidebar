require 'spec_helper'

describe 'authors index', type: :feature, js: true do

  before do
    Author.create!(name: 'John', last_name: 'Doe')
    Author.create!(name: 'Jane', last_name: 'Roe')
  end

  context 'left-sidebar with collapsible: true (starts expanded)' do
    before do
      add_author_resource
      add_post_resource
      visit '/admin/authors'
    end

    it 'has left-sidebar with toggle button' do
      expect(page).to have_css('#filters_sidebar_section')
      expect(page).to have_css('.sidebar_toggle_btn')
      expect(page).to have_css('#active_admin_content.with_sidebar.left_sidebar.collapsible_sidebar')
    end

    it 'sidebar starts expanded' do
      expect(page).to have_css('#sidebar .sidebar_section', visible: :visible)
      expect(page).not_to have_css('#active_admin_content.collapsed_sidebar')
    end

    context 'when click on toggle to collapse' do
      before do
        page.find('.sidebar_toggle_btn').click
      end

      it "sidebar is hidden, and save it's state after going to another page" do
        expect(page).to have_css('#active_admin_content.collapsed_sidebar')

        # Posts page is configured as: "before_action :skip_sidebar!"
        visit '/admin/posts'
        # sidebar does not exist at all
        expect(page).to have_css('#page_title', text: 'Posts')
        expect(page).not_to have_css('#sidebar', visible: :all)

        visit '/admin/authors'
        # sidebar is collapsed
        expect(page).to have_css('#page_title', text: 'Authors')
        expect(page).to have_css('#active_admin_content.collapsed_sidebar')

        page.find('.sidebar_toggle_btn').click

        # sidebar is visible
        expect(page).to have_css('#sidebar .sidebar_section', visible: :visible)
        expect(page).not_to have_css('#active_admin_content.collapsed_sidebar')
      end
    end

  end

  context 'left-sidebar with collapsible: true, start_collapsed: true' do
    before do
      add_author_resource_with_start_collapsed
      add_post_resource
      visit '/admin/authors'
    end

    it 'has collapsible sidebar that starts collapsed' do
      expect(page).to have_css('#active_admin_content.collapsible_sidebar.collapsed_sidebar')
      expect(page).to have_css('.sidebar_toggle_btn')
    end

    it 'can be expanded by clicking toggle button' do
      page.find('.sidebar_toggle_btn').click

      expect(page).to have_css('#sidebar .sidebar_section', visible: :visible)
      expect(page).not_to have_css('#active_admin_content.collapsed_sidebar')

      # session remembers expanded state
      visit '/admin/authors'
      expect(page).to have_css('#sidebar .sidebar_section', visible: :visible)
      expect(page).not_to have_css('#active_admin_content.collapsed_sidebar')
    end
  end

  context 'deprecated collapsed option raises error' do
    it 'raises ArgumentError for left_sidebar!' do
      obj = Object.new
      obj.extend(ActiveAdminSidebar::Positions)
      expect { obj.left_sidebar!(collapsed: true) }.to raise_error(ArgumentError, /removed in v3/)
    end

    it 'raises ArgumentError for right_sidebar!' do
      obj = Object.new
      obj.extend(ActiveAdminSidebar::Positions)
      expect { obj.right_sidebar!(collapsed: true) }.to raise_error(ArgumentError, /removed in v3/)
    end
  end

  context 'right-sidebar with collapsible: true (starts expanded)' do
    before do
      add_author_resource_right_sidebar
      add_post_resource
      visit '/admin/authors'
    end

    it 'has right-sidebar with toggle button' do
      expect(page).to have_css('#filters_sidebar_section')
      expect(page).to have_css('.sidebar_toggle_btn')
      expect(page).to have_css('#active_admin_content.with_sidebar.collapsible_sidebar')
      expect(page).not_to have_css('#active_admin_content.left_sidebar')
    end

    it 'sidebar starts expanded' do
      expect(page).to have_css('#sidebar .sidebar_section', visible: :visible)
      expect(page).not_to have_css('#active_admin_content.collapsed_sidebar')
    end

    context 'when click on toggle to collapse' do
      before do
        page.find('.sidebar_toggle_btn').click
      end

      it 'sidebar is hidden and toggle button is on the right side' do
        expect(page).to have_css('#active_admin_content.collapsed_sidebar')

        btn_left = page.evaluate_script("document.querySelector('.sidebar_toggle_btn').getBoundingClientRect().left")
        page_width = page.evaluate_script('document.documentElement.clientWidth')
        expect(btn_left).to be > (page_width / 2), "toggle button should be on the right side of the page"

        page.find('.sidebar_toggle_btn').click

        expect(page).not_to have_css('#active_admin_content.collapsed_sidebar')
        expect(page).to have_css('#sidebar .sidebar_section', visible: :visible)
      end
    end
  end

  context 'right-sidebar with collapsible: true, start_collapsed: true' do
    before do
      add_author_resource_right_sidebar_start_collapsed
      add_post_resource
      visit '/admin/authors'
    end

    it 'has collapsible right-sidebar that starts collapsed' do
      expect(page).to have_css('#active_admin_content.collapsible_sidebar.collapsed_sidebar')
      expect(page).to have_css('.sidebar_toggle_btn')
    end

    it 'can be expanded by clicking toggle button' do
      page.find('.sidebar_toggle_btn').click

      expect(page).to have_css('#sidebar .sidebar_section', visible: :visible)
      expect(page).not_to have_css('#active_admin_content.collapsed_sidebar')

      # session remembers expanded state
      visit '/admin/authors'
      expect(page).to have_css('#sidebar .sidebar_section', visible: :visible)
      expect(page).not_to have_css('#active_admin_content.collapsed_sidebar')
    end
  end

  context 'per-resource sidebar state isolation' do
    before do
      Post.create!(title: 'Test', body: 'Body', author: Author.first)
      add_author_resource_with_start_collapsed
      add_post_resource_with_sidebar
    end

    it 'changing sidebar state on one resource does not affect another' do
      # Authors starts collapsed (collapsible: true, start_collapsed: true)
      visit '/admin/authors'
      expect(page).to have_css('#active_admin_content.collapsed_sidebar')

      # Expand authors
      page.find('.sidebar_toggle_btn').click
      expect(page).to have_css('#sidebar .sidebar_section', visible: :visible)

      # Posts should still be in its default state (expanded, not collapsed)
      visit '/admin/posts'
      expect(page).to have_css('#active_admin_content.collapsible_sidebar')
      expect(page).not_to have_css('#active_admin_content.collapsed_sidebar')

      # Authors should still be expanded (from earlier toggle)
      visit '/admin/authors'
      expect(page).to have_css('#sidebar .sidebar_section', visible: :visible)
      expect(page).not_to have_css('#active_admin_content.collapsed_sidebar')
    end
  end

end
