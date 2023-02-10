require 'rails_helper'

RSpec.describe 'RecordError' do
  it 'exists and has attributes' do
    rec_error1 = RecordError.new

    expect(rec_error1.message).to eq('Content is Invalid')
    expect(rec_error1.details).to eq('Record is Invalid')
    expect(rec_error1.exception_type).to eq('Records')
    expect(rec_error1.status).to eq(400)

    rec_error2 = RecordError.new(message: 'Pants are Invalid', details: 'No Explanation Required', status: 404)

    expect(rec_error2.message).to eq('Pants are Invalid')
    expect(rec_error2.details).to eq('No Explanation Required')
    expect(rec_error2.exception_type).to eq('Records')
    expect(rec_error2.status).to eq(404)
  end
end
