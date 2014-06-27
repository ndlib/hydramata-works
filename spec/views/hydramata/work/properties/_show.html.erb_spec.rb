require 'spec_view_helper'

# As of 3.0.x :type tags are no longer inferred.
# This means, without the `type: :view` tag, the render method does not exist
# in the example context
describe 'hydramata/work/properties/_show.html.erb', type: :view do
  let(:object) { double('Object', t: true, dom_class: 'my-dom-class', values: ['value1', 'value2']) }

  it 'renders the object and fieldsets' do
    expect(object).to receive(:container_content_tag_attributes).with(class: 'label').and_return(class: ['my-dom-class', 'label'])
    expect(object).to receive(:container_content_tag_attributes).with(class: 'value').and_return(class: ['my-dom-class', 'value']).at_least(1).times
    expect(object).to receive(:t).with(:name).and_return('Label')
    render partial: 'hydramata/work/properties/show', object: object

    expect(rendered).to have_tag('.my-dom-class.label', text: 'Label')
    expect(rendered).to have_tag('.my-dom-class.value', text: 'value1')
    expect(rendered).to have_tag('.my-dom-class.value', text: 'value2')

  end
end