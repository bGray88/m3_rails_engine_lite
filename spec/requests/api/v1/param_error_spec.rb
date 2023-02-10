require 'rails_helper'

RSpec.describe 'ParamError' do
  it 'exists and has attributes' do
    par_error1 = ParamError.new

    expect(par_error1.message).to eq('Content is Invalid')
    expect(par_error1.details).to eq('Param is Invalid')
    expect(par_error1.exception_type).to eq('Params')
    expect(par_error1.status).to eq(400)

    par_error2 = ParamError.new(message: 'Pants are Invalid', details: 'No Explanation Required', status: 404)

    expect(par_error2.message).to eq('Pants are Invalid')
    expect(par_error2.details).to eq('No Explanation Required')
    expect(par_error2.exception_type).to eq('Params')
    expect(par_error2.status).to eq(404)
  end
end
