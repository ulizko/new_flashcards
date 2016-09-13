require 'rails_helper'

RSpec.describe MailerJob, type: :job do
  let(:email) { 'test@email.com' }
  subject(:job) { described_class.perform_later(email) }

  it 'job is queued' do
    expect{ subject }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'executes perform' do
    expect(CardsMailer).to receive(:pending_cards_notification).with(email)
    perform_enqueued_jobs { job }
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
