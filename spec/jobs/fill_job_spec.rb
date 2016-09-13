require 'rails_helper'

RSpec.describe FillJob, type: :job do
  let(:options) do
    { url: 'url',
      original_text_selector: 'original_text_selector',
      translated_text_selector: 'translated_text_selector' }
  end
  let(:user) { create(:user) }
  subject(:job) { described_class.perform_later(user, options) }

  it 'job is queued' do
    expect{ subject }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'executes perform' do
    data = double
    allow(Fill).to receive(:start).with(options).and_return(data)
    allow(data).to receive(:each)
    perform_enqueued_jobs { job }
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
