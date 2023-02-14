
const reportWebVitals = onPerfEntry => {
  if (onPerfEntry && onPerfEntry instanceof Function) {
    import('web-vitals').then(({ getCLS, getFID, getFCP, getLCP, getTTFB }) => {
      getCLS(onPerfEntry);
      getFID(onPerfEntry);
      getFCP(onPerfEntry);
      getLCP(onPerfEntry);
      getTTFB(onPerfEntry);
    });
  }
};

export default reportWebVitals;

/*
The reportWebVitals function calls the following performance metric functions: getCLS, getFID, getFCP, getLCP, and getTTFB. These functions provide the following metrics:

getCLS: reports the cumulative layout shift score, which measures the amount of unexpected layout shift on a page
getFID: reports the first input delay, which measures the time from when a user first interacts with a page to the time when the browser is able to respond to the interaction
getFCP: reports the first contentful paint, which measures the time from when a page starts loading to when the first piece of content is painted on the screen
getLCP: reports the largest contentful paint, which measures the render time of the largest image or text block visible within the viewport
getTTFB: reports the time to first byte, which measures the time it takes for the first byte of a response to be received from a server
*/