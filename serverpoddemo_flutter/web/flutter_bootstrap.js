{{flutter_js}}
{{flutter_build_config}}

// Flutter's compiled entrypoints use stable filenames. Add the generated
// build version to their URLs so a deployment cannot execute an older client
// bundle that was cached by the browser or an edge proxy.
const cacheVersion = {{flutter_service_worker_version}};
for (const build of _flutter.buildConfig.builds) {
  for (const key of ['mainWasmPath', 'jsSupportRuntimePath', 'mainJsPath']) {
    if (build[key]) build[key] = `${build[key]}?v=${cacheVersion}`;
  }
}

_flutter.loader.load();
