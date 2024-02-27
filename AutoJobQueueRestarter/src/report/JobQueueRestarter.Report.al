report 50100 "Job Queue Restarter"
{
    Caption = 'Job Queue Restarter';
    UsageCategory = Administration;
    ApplicationArea = Basic, Suite;

    dataset
    {
        dataitem(JobQueueEntry; "Job Queue Entry")
        {
            DataItemTableView = where(Status = const(Status::Error));
            RequestFilterFields = "Job Queue Category Code",
                                  "Object Type to Run",
                                  "Object ID to Run";

            trigger OnAfterGetRecord()
            var
                RestartedJobQueueEntry: Record "Job Queue Entry";
            begin
                RestartedJobQueueEntry.Get(JobQueueEntry.ID);
                RestartedJobQueueEntry.SetStatus(RestartedJobQueueEntry.Status::Ready);
            end;
        }
    }
}
