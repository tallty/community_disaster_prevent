require 'acceptance_helper'

resource "灾情互动" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  get "/disasters/get_disaster" do
    parameter :start_time, "开始时间", required: true
    parameter :end_time, "结束时间", required: true
    
    let(:start_time) { "2015-06-01" }
    let(:end_time) { "2015-11-01" }
    let(:raw_post) { params.to_json }

    example "获取数据" do
      do_request
      expect(status).to eq(200)
    end
  end
end
