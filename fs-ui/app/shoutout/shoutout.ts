import { FSObject }           from '../fsprocess/FSObject';

export interface ShoutOut extends FSObject {
    receiverId: string;
    receiverName: string;
    giverId: string;
    giverName: string;
    opportunityId: string;
    opportunityName: string;
    comments: string;
    reason: string;
}
