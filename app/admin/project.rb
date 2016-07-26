ActiveAdmin.register Project do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :title, :description, :status, :valid_till, :discount, :notes, :terms, :code

  # Scope
  scope :all, :default => true
  scope :draft do |invoices|
    invoices.where(:status => Project::STATUS_DRAFT)
  end
  scope :sent do |invoices|
    invoices.where(:status => Project::STATUS_SENT)
  end
  scope :paid do |invoices|
    invoices.where(:status => Project::STATUS_PAID)
  end

  # Project Filters
  # TODO: filter :client
  filter :code
  filter :valid_till

  # Projects Index
  index do
    column :status do |project|
      status_tag project.status, project.status_tag
    end
    column :code do |project|
      link_to "##{project.code}", admin_project_path(project)
    end

    column :client

    column "Issued" do |project|
      due = if project.valid_till
        " (due in #{distance_of_time_in_words Time.now, project.valid_till})"
      else
        ""
      end

      "#{l project.created_at, :format => :short}" + due
    end
    # column :total do |project|
    #   number_to_currency project.total
    # end

    column do |project|
      link_to("Details", admin_project_path(project)) + " | " + \
      link_to("Edit", edit_admin_project_path(project)) + " | " + \
      link_to("Delete", admin_project_path(project), :method => :delete, :confirm => "Are you sure?")
    end
  end

  # Projects Show
  show :title => :code do
    panel "Project Details" do
      attributes_table_for project do
        row("Code") { project.code }
        row("Status") { status_tag project.status, project.status_tag }
        row("Issue Date") { project.created_at }
        row("Due Date") { project.valid_till }
      end
    end

    # panel "Items" do
    #   table_for invoice.items do |t|
    #     t.column("Qty.") { |item| number_with_delimiter item.quantity }
    #     t.column("Description") { |item| item.description }
    #     t.column("Per Unit") { |item| number_to_currency item.amount }
    #     t.column("Total") { |item| number_to_currency item.total}
    #
    #     # Show the tax, discount, subtotal and total
    #     tr do
    #       2.times { td "" }
    #       td "Discount:", :style => "text-align:right; font-weight: bold;"
    #       td "#{number_with_delimiter(invoice.discount)}%"
    #     end
    #
    #     tr do
    #       2.times { td "" }
    #       td "Sub-total:", :style => "text-align:right; font-weight: bold;"
    #       td "#{number_to_currency(invoice.subtotal)}%"
    #     end
    #
    #     tr do
    #       2.times { td "" }
    #       td "Taxes:", :style => "text-align:right; font-weight: bold;"
    #       td "#{number_to_currency(invoice.taxes)} (#{number_with_delimiter(invoice.tax)}%)"
    #     end
    #
    #     tr do
    #       2.times { td "" }
    #       td "Total:", :style => "text-align:right; font-weight: bold;"
    #       td "#{number_to_currency(invoice.total)}%", :style => "font-weight: bold;"
    #     end
    #   end
    # end

    panel "Other" do
      attributes_table_for project do
        row("Terms") { simple_format project.terms }
        row("Notes") { simple_format project.notes }
      end
    end
  end


end
