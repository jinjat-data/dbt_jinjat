import { JinjatApp } from "@jinjatdata/core";
import { useMemo } from "react";

export default function App ({...props}) {
    return useMemo(
        () => <JinjatApp {...props} apiUrl={"http://127.0.0.1:8581"}/>,
        [props]
      );
}