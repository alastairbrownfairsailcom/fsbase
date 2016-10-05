import { FSObject }           from '../interfaces/fsobject';

export interface ShoutOut extends FSObject {
    id: string;
    receiverId: string;
    receiverName: string;
    giverId: string;
    giverName: string;
    opportunityId: string;
    opportunityName: string;
    comments: string;
    reason: string;
}
