export interface FSOption {
    value: string;
    displayName: string;
    isDefault: boolean;
}

export interface FSFieldMetadata {
    path: string;
    fieldType : string;
    displayName : string;
    options : FSOption[];
}

export interface FSObjectMetadata {
    objectType : string;
    displayName : string;
    fields : FSFieldMetadata[];
    children : FSObjectMetadata[];
}

export interface FSProcess {
    id: string;
    processName: string;
    displayName: string;
    componentName: string;
    objects: FSObjectMetadata[];
}
