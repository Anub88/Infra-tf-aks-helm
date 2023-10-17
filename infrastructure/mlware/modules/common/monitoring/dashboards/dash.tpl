{
  "lenses": {
    "0": {
      "order": 0,
      "parts": {
        "0": {
          "position": {
            "x": 0,
            "y": 0,
            "colSpan": 18,
            "rowSpan": 1
          },
          "metadata": {
            "inputs": [],
            "type": "Extension/HubsExtension/PartType/MarkdownPart",
            "settings": {
              "content": {
                "content": "# EVENTHUB - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ",
                "title": "",
                "subtitle": "",
                "markdownSource": 1,
                "markdownUri": ""
              }
            }
          }
        },
        "1": {
          "position": {
            "x": 0,
            "y": 1,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "sharedTimeRange",
                "isOptional": true
              },
              {
                "name": "options",
                "value": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "IncomingRequests",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Incoming Requests",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "SuccessfulRequests",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Successful Requests",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "ServerErrors",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Server Errors.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "UserErrors",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "User Errors.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "ThrottledRequests",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Throttled Requests.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      }
                    ],
                    "title": "Requests",
                    "titleKind": 2,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      }
                    },
                    "timespan": {
                      "relative": {
                        "duration": 2592000000
                      },
                      "showUTCTime": false,
                      "grain": 1
                    }
                  }
                },
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "IncomingRequests",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Incoming Requests",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "SuccessfulRequests",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Successful Requests",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "ServerErrors",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Server Errors.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "UserErrors",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "User Errors.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "ThrottledRequests",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Throttled Requests.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      }
                    ],
                    "title": "Requests",
                    "titleKind": 2,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      },
                      "disablePinning": true
                    }
                  }
                }
              }
            },
            "filters": {
              "MsPortalFx_TimeRange": {
                "model": {
                  "format": "local",
                  "granularity": "auto",
                  "relative": "1440m"
                }
              }
            }
          }
        },
        "2": {
          "position": {
            "x": 6,
            "y": 1,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "sharedTimeRange",
                "isOptional": true
              },
              {
                "name": "options",
                "value": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "IncomingMessages",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Incoming Messages",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "OutgoingMessages",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Outgoing Messages",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "CapturedMessages",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Captured Messages.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "CaptureBacklog",
                        "aggregationType": 4,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Capture Backlog.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      }
                    ],
                    "title": "Messages",
                    "titleKind": 2,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      }
                    },
                    "timespan": {
                      "relative": {
                        "duration": 2592000000
                      },
                      "showUTCTime": false,
                      "grain": 1
                    }
                  }
                },
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "IncomingMessages",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Incoming Messages",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "OutgoingMessages",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Outgoing Messages",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "CapturedMessages",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Captured Messages.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "CaptureBacklog",
                        "aggregationType": 4,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Capture Backlog.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      }
                    ],
                    "title": "Messages",
                    "titleKind": 2,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      },
                      "disablePinning": true
                    }
                  }
                }
              }
            },
            "filters": {
              "MsPortalFx_TimeRange": {
                "model": {
                  "format": "local",
                  "granularity": "auto",
                  "relative": "1440m"
                }
              }
            }
          }
        },
        "3": {
          "position": {
            "x": 12,
            "y": 1,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "sharedTimeRange",
                "isOptional": true
              },
              {
                "name": "options",
                "value": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "IncomingBytes",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Incoming Bytes.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "OutgoingBytes",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Outgoing Bytes.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "CapturedBytes",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Captured Bytes.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      }
                    ],
                    "title": "Throughput",
                    "titleKind": 2,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      }
                    },
                    "timespan": {
                      "relative": {
                        "duration": 2592000000
                      },
                      "showUTCTime": false,
                      "grain": 1
                    }
                  }
                },
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "IncomingBytes",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Incoming Bytes.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "OutgoingBytes",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Outgoing Bytes.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "CapturedBytes",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Captured Bytes.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      }
                    ],
                    "title": "Throughput",
                    "titleKind": 2,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      },
                      "disablePinning": true
                    }
                  }
                }
              }
            },
            "filters": {
              "MsPortalFx_TimeRange": {
                "model": {
                  "format": "local",
                  "granularity": "auto",
                  "relative": "1440m"
                }
              }
            }
          }
        },
        "4": {
          "position": {
            "x": 0,
            "y": 5,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "sharedTimeRange",
                "isOptional": true
              },
              {
                "name": "options",
                "value": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "SuccessfulRequests",
                        "aggregationType": 4,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Successful Requests"
                        }
                      }
                    ],
                    "title": "Avg Successful Requests by EntityName",
                    "titleKind": 1,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      }
                    },
                    "grouping": {
                      "dimension": "EntityName",
                      "sort": 2,
                      "top": 10
                    },
                    "timespan": {
                      "relative": {
                        "duration": 86400000
                      },
                      "showUTCTime": false,
                      "grain": 1
                    }
                  }
                },
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "SuccessfulRequests",
                        "aggregationType": 4,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Successful Requests"
                        }
                      }
                    ],
                    "title": "Avg Successful Requests by EntityName",
                    "titleKind": 1,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      },
                      "disablePinning": true
                    },
                    "grouping": {
                      "dimension": "EntityName",
                      "sort": 2,
                      "top": 10
                    }
                  }
                }
              }
            },
            "filters": {
              "MsPortalFx_TimeRange": {
                "model": {
                  "format": "local",
                  "granularity": "auto",
                  "relative": "1440m"
                }
              }
            }
          }
        },
        "5": {
          "position": {
            "x": 6,
            "y": 5,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "sharedTimeRange",
                "isOptional": true
              },
              {
                "name": "options",
                "value": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "IncomingBytes",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Incoming Bytes."
                        }
                      }
                    ],
                    "title": "Sum Incoming Bytes. by EntityName",
                    "titleKind": 1,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      }
                    },
                    "grouping": {
                      "dimension": "EntityName",
                      "sort": 2,
                      "top": 10
                    },
                    "timespan": {
                      "relative": {
                        "duration": 86400000
                      },
                      "showUTCTime": false,
                      "grain": 1
                    }
                  }
                },
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "IncomingBytes",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Incoming Bytes."
                        }
                      }
                    ],
                    "title": "Sum Incoming Bytes. by EntityName",
                    "titleKind": 1,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      },
                      "disablePinning": true
                    },
                    "grouping": {
                      "dimension": "EntityName",
                      "sort": 2,
                      "top": 10
                    }
                  }
                }
              }
            },
            "filters": {
              "MsPortalFx_TimeRange": {
                "model": {
                  "format": "local",
                  "granularity": "auto",
                  "relative": "1440m"
                }
              }
            }
          }
        },
        "6": {
          "position": {
            "x": 12,
            "y": 5,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "sharedTimeRange",
                "isOptional": true
              },
              {
                "name": "options",
                "value": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "UserErrors",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "User Errors."
                        }
                      }
                    ],
                    "title": "Sum User Errors. by EntityName",
                    "titleKind": 1,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      }
                    },
                    "grouping": {
                      "dimension": "EntityName",
                      "sort": 2,
                      "top": 10
                    },
                    "timespan": {
                      "relative": {
                        "duration": 86400000
                      },
                      "showUTCTime": false,
                      "grain": 1
                    }
                  }
                },
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "UserErrors",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "User Errors."
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "ServerErrors",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Server Errors."
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "QuotaExceededErrors",
                        "aggregationType": 1,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Quota Exceeded Errors."
                        }
                      }
                    ],
                    "title": "Sum User Errors., Sum Server Errors., and Sum Quota Exceeded Errors.",
                    "titleKind": 1,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      },
                      "disablePinning": true
                    }
                  }
                }
              }
            },
            "filters": {
              "MsPortalFx_TimeRange": {
                "model": {
                  "format": "utc",
                  "granularity": "auto",
                  "relative": "1440m"
                }
              }
            }
          }
        },
        "7": {
          "position": {
            "x": 0,
            "y": 9,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "options",
                "isOptional": true
              },
              {
                "name": "sharedTimeRange",
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "ConnectionsOpened",
                        "aggregationType": 4,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Connections Opened.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "ConnectionsClosed",
                        "aggregationType": 4,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Connections Closed.",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "ActiveConnections",
                        "aggregationType": 4,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "ActiveConnections",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      }
                    ],
                    "title": "Avg Connections Opened., Avg Connections Closed., and Avg ActiveConnections",
                    "titleKind": 1,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      },
                      "disablePinning": true
                    }
                  }
                }
              }
            }
          }
        },
        "8": {
          "position": {
            "x": 6,
            "y": 9,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "options",
                "isOptional": true
              },
              {
                "name": "sharedTimeRange",
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "NamespaceCpuUsage",
                        "aggregationType": 4,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "CPU",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${eventhub_id}"
                        },
                        "name": "NamespaceMemoryUsage",
                        "aggregationType": 4,
                        "namespace": "microsoft.eventhub/namespaces",
                        "metricVisualization": {
                          "displayName": "Memory Usage",
                          "resourceDisplayName": "${eventhub_name}"
                        }
                      }
                    ],
                    "title": "Avg CPU and Avg Memory Usage",
                    "titleKind": 1,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      },
                      "disablePinning": true
                    }
                  }
                }
              }
            }
          }
        },
        "9": {
          "position": {
            "x": 0,
            "y": 13,
            "colSpan": 18,
            "rowSpan": 1
          },
          "metadata": {
            "inputs": [],
            "type": "Extension/HubsExtension/PartType/MarkdownPart",
            "settings": {
              "content": {
                "content": "# Cluster - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  ",
                "title": "",
                "subtitle": "",
                "markdownSource": 1,
                "markdownUri": ""
              }
            }
          }
        },
        "10": {
          "position": {
            "x": 0,
            "y": 14,
            "colSpan": 9,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "queryParams",
                "value": {
                  "metricQueryId": "cpu",
                  "clusterName": "${kubernetes_name}",
                  "clusterResourceId": "${kubernetes_id}",
                  "workspaceResourceId": "${log_analytics_workspace_id}",
                  "timeRange": {
                    "options": {},
                    "relative": {
                      "duration": 21600000
                    }
                  },
                  "cpuFilterSelection": "total",
                  "memoryFilterSelection": "total_memoryrss"
                }
              },
              {
                "name": "bladeName",
                "value": "SingleCluster.ReactView"
              },
              {
                "name": "extensionName",
                "value": "Microsoft_Azure_ContainerInsightsExt"
              },
              {
                "name": "bladeParams",
                "value": {
                  "useAADAuth": false,
                  "clusterIdentityType": "SystemAssigned",
                  "armClusterPath": "${kubernetes_id}",
                  "armWorkspacePath": "${log_analytics_workspace_id}",
                  "clusterRegion": "${region}",
                  "initiator": "ManagedClusterAsset.getMenuConfig",
                  "containerClusterResourceId": "${kubernetes_id}",
                  "containerClusterName": "${kubernetes_name}",
                  "workspaceResourceId": "${log_analytics_workspace_id}"
                }
              },
              {
                "name": "defaultOptionPicks",
                "value": [
                  {
                    "id": "Avg",
                    "displayName": "Avg",
                    "isSelected": true
                  },
                  {
                    "id": "Min",
                    "displayName": "Min",
                    "isSelected": false
                  },
                  {
                    "id": "P50",
                    "displayName": "50th",
                    "isSelected": false
                  },
                  {
                    "id": "P90",
                    "displayName": "90th",
                    "isSelected": false
                  },
                  {
                    "id": "P95",
                    "displayName": "95th",
                    "isSelected": false
                  },
                  {
                    "id": "Max",
                    "displayName": "Max",
                    "isSelected": true
                  }
                ]
              },
              {
                "name": "showOptionPicker",
                "value": true
              }
            ],
            "type": "Extension/Microsoft_Azure_ContainerInsightsExt/PartType/ChartPart"
          }
        },
        "11": {
          "position": {
            "x": 9,
            "y": 14,
            "colSpan": 9,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "queryParams",
                "value": {
                  "metricQueryId": "memory",
                  "clusterName": "${kubernetes_name}",
                  "clusterResourceId": "${kubernetes_id}",
                  "workspaceResourceId": "${log_analytics_workspace_id}",
                  "timeRange": {
                    "options": {},
                    "relative": {
                      "duration": 21600000
                    }
                  },
                  "cpuFilterSelection": "total",
                  "memoryFilterSelection": "total_memoryrss"
                }
              },
              {
                "name": "bladeName",
                "value": "SingleCluster.ReactView"
              },
              {
                "name": "extensionName",
                "value": "Microsoft_Azure_ContainerInsightsExt"
              },
              {
                "name": "bladeParams",
                "value": {
                  "useAADAuth": false,
                  "clusterIdentityType": "SystemAssigned",
                  "armClusterPath": "${kubernetes_id}",
                  "armWorkspacePath": "${log_analytics_workspace_id}",
                  "clusterRegion": "${region}",
                  "initiator": "ManagedClusterAsset.getMenuConfig",
                  "containerClusterResourceId": "${kubernetes_id}",
                  "containerClusterName": "${kubernetes_name}",
                  "workspaceResourceId": "${log_analytics_workspace_id}"
                }
              },
              {
                "name": "defaultOptionPicks",
                "value": [
                  {
                    "id": "Avg",
                    "displayName": "Avg",
                    "isSelected": true
                  },
                  {
                    "id": "Min",
                    "displayName": "Min",
                    "isSelected": false
                  },
                  {
                    "id": "P50",
                    "displayName": "50th",
                    "isSelected": false
                  },
                  {
                    "id": "P90",
                    "displayName": "90th",
                    "isSelected": false
                  },
                  {
                    "id": "P95",
                    "displayName": "95th",
                    "isSelected": false
                  },
                  {
                    "id": "Max",
                    "displayName": "Max",
                    "isSelected": true
                  }
                ]
              },
              {
                "name": "showOptionPicker",
                "value": true
              }
            ],
            "type": "Extension/Microsoft_Azure_ContainerInsightsExt/PartType/ChartPart"
          }
        },
        "12": {
          "position": {
            "x": 0,
            "y": 18,
            "colSpan": 9,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "queryParams",
                "value": {
                  "metricQueryId": "node-count",
                  "clusterName": "${kubernetes_name}",
                  "clusterResourceId": "${kubernetes_id}",
                  "workspaceResourceId": "${log_analytics_workspace_id}",
                  "timeRange": {
                    "options": {},
                    "relative": {
                      "duration": 21600000
                    }
                  },
                  "cpuFilterSelection": "total",
                  "memoryFilterSelection": "total_memoryrss"
                }
              },
              {
                "name": "bladeName",
                "value": "SingleCluster.ReactView"
              },
              {
                "name": "extensionName",
                "value": "Microsoft_Azure_ContainerInsightsExt"
              },
              {
                "name": "bladeParams",
                "value": {
                  "useAADAuth": false,
                  "clusterIdentityType": "SystemAssigned",
                  "armClusterPath": "${kubernetes_id}",
                  "armWorkspacePath": "${log_analytics_workspace_id}",
                  "clusterRegion": "${region}",
                  "initiator": "ManagedClusterAsset.getMenuConfig",
                  "containerClusterResourceId": "${kubernetes_id}",
                  "containerClusterName": "${kubernetes_name}",
                  "workspaceResourceId": "${log_analytics_workspace_id}"
                }
              },
              {
                "name": "defaultOptionPicks",
                "value": [
                  {
                    "id": "All",
                    "displayName": "Total",
                    "isSelected": false
                  },
                  {
                    "id": "Ready",
                    "displayName": "Ready",
                    "isSelected": true
                  },
                  {
                    "id": "NotReady",
                    "displayName": "Not Ready",
                    "isSelected": true
                  }
                ]
              },
              {
                "name": "showOptionPicker",
                "value": true
              }
            ],
            "type": "Extension/Microsoft_Azure_ContainerInsightsExt/PartType/ChartPart"
          }
        },
        "13": {
          "position": {
            "x": 9,
            "y": 18,
            "colSpan": 9,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "queryParams",
                "value": {
                  "metricQueryId": "pod-count",
                  "clusterName": "${kubernetes_name}",
                  "clusterResourceId": "${kubernetes_id}",
                  "workspaceResourceId": "${log_analytics_workspace_id}",
                  "timeRange": {
                    "options": {},
                    "relative": {
                      "duration": 21600000
                    }
                  },
                  "cpuFilterSelection": "total",
                  "memoryFilterSelection": "total_memoryrss"
                }
              },
              {
                "name": "bladeName",
                "value": "SingleCluster.ReactView"
              },
              {
                "name": "extensionName",
                "value": "Microsoft_Azure_ContainerInsightsExt"
              },
              {
                "name": "bladeParams",
                "value": {
                  "useAADAuth": false,
                  "clusterIdentityType": "SystemAssigned",
                  "armClusterPath": "${kubernetes_id}",
                  "armWorkspacePath": "${log_analytics_workspace_id}",
                  "clusterRegion": "${region}",
                  "initiator": "ManagedClusterAsset.getMenuConfig",
                  "containerClusterResourceId": "${kubernetes_id}",
                  "containerClusterName": "${kubernetes_name}",
                  "workspaceResourceId": "${log_analytics_workspace_id}"
                }
              },
              {
                "name": "defaultOptionPicks",
                "value": [
                  {
                    "id": "all",
                    "displayName": "Total",
                    "isSelected": false
                  },
                  {
                    "id": "pending",
                    "displayName": "Pending",
                    "isSelected": true
                  },
                  {
                    "id": "running",
                    "displayName": "Running",
                    "isSelected": true
                  },
                  {
                    "id": "unknown",
                    "displayName": "Unknown",
                    "isSelected": true
                  },
                  {
                    "id": "succeeded",
                    "displayName": "Succeeded",
                    "isSelected": true
                  },
                  {
                    "id": "failed",
                    "displayName": "Failed",
                    "isSelected": true
                  },
                  {
                    "id": "terminating",
                    "displayName": "Terminating",
                    "isSelected": true
                  }
                ]
              },
              {
                "name": "showOptionPicker",
                "value": true
              }
            ],
            "type": "Extension/Microsoft_Azure_ContainerInsightsExt/PartType/ChartPart"
          }
        },
        "14": {
          "position": {
            "x": 0,
            "y": 22,
            "colSpan": 18,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "ComponentId",
                "value": "${kubernetes_id}",
                "isOptional": true
              },
              {
                "name": "TimeContext",
                "value": null,
                "isOptional": true
              },
              {
                "name": "ResourceIds",
                "value": [
                  "${kubernetes_id}"
                ],
                "isOptional": true
              },
              {
                "name": "ConfigurationId",
                "value": "Community-Workbooks/AKS/Deployments and HPAs",
                "isOptional": true
              },
              {
                "name": "Type",
                "value": "container-insights",
                "isOptional": true
              },
              {
                "name": "GalleryResourceType",
                "value": "microsoft.containerservice/managedclusters",
                "isOptional": true
              },
              {
                "name": "PinName",
                "value": "Deployments",
                "isOptional": true
              },
              {
                "name": "StepSettings",
                "value": "{\"version\":\"KqlItem/1.0\",\"query\":\"let data = materialize(\\r\\nInsightsMetrics\\r\\n| where Name == \\\"kube_deployment_status_replicas_ready\\\"\\r\\n| extend Tags = parse_json(Tags)\\r\\n| extend ClusterId = Tags[\\\"container.azm.ms/clusterId\\\"]\\r\\n{clusterIdWhereClause}\\r\\n| where Tags.deployment in ({deploymentName})\\r\\n| extend Deployment = tostring(Tags.deployment)\\r\\n| extend k8sNamespace = tostring(Tags.k8sNamespace)\\r\\n| extend Ready = Val/Tags.spec_replicas * 100, Updated = Val/Tags.status_replicas_updated * 100, Available = Val/Tags.status_replicas_available * 100\\r\\n| project k8sNamespace, Deployment, Ready, Updated, Available, TimeGenerated, Tags\\r\\n);\\r\\nlet data2 = data\\r\\n| extend Age = (now() - todatetime(Tags[\\\"creationTime\\\"]))/1m\\r\\n| summarize arg_max(TimeGenerated, *) by k8sNamespace, Deployment\\r\\n| project k8sNamespace, Deployment, Age, Ready, Updated, Available;\\r\\nlet ReadyData = data\\r\\n| make-series ReadyTrend = avg(Ready) default = 0 on TimeGenerated from {timeRange:start} to {timeRange:end} step {timeRange:grain} by k8sNamespace, Deployment;\\r\\nlet UpdatedData = data\\r\\n| make-series UpdatedTrend = avg(Updated) default = 0 on TimeGenerated from {timeRange:start} to {timeRange:end} step {timeRange:grain} by k8sNamespace, Deployment;\\r\\nlet AvailableData = data\\r\\n| make-series AvailableTrend = avg(Available) default = 0 on TimeGenerated from {timeRange:start} to {timeRange:end} step {timeRange:grain} by k8sNamespace, Deployment;\\r\\ndata2\\r\\n| join kind = inner(ReadyData) on k8sNamespace, Deployment \\r\\n| join kind = inner(UpdatedData) on k8sNamespace, Deployment \\r\\n| join kind = inner(AvailableData) on k8sNamespace, Deployment\\r\\n| extend ReadyCase = case(Ready == 100, \\\"Healthy\\\", \\\"Warning\\\"),  UpdatedCase = case(Updated == 100, \\\"Healthy\\\", \\\"Warning\\\"),  AvailableCase = case(Available == 100, \\\"Healthy\\\", \\\"Warning\\\")\\r\\n| extend Overall = case(ReadyCase == \\\"Healthy\\\" and UpdatedCase == \\\"Healthy\\\" and AvailableCase == \\\"Healthy\\\", \\\"Healthy\\\", \\\"Warning\\\")\\r\\n| extend OverallFilterStatus = case('{OverallFilter}' contains \\\"Healthy\\\", \\\"Healthy\\\", '{OverallFilter}' contains \\\"Warning\\\", \\\"Warning\\\", \\\"Healthy, Warning\\\")\\r\\n| where OverallFilterStatus has Overall\\r\\n| project Deployment, Namespace = k8sNamespace, Age, Ready, ReadyTrend, Updated, UpdatedTrend, Available,AvailableTrend\\r\\n| sort by Ready asc\\r\\n\",\"size\":0,\"showAnalytics\":true,\"timeContext\":{\"durationMs\":86400000},\"showExportToExcel\":true,\"queryType\":0,\"resourceType\":\"{resourceType}\",\"crossComponentResources\":[\"{resource}\"],\"visualization\":\"table\",\"gridSettings\":{\"formatters\":[{\"columnMatch\":\"Age\",\"formatter\":0,\"numberFormat\":{\"unit\":25,\"options\":{\"style\":\"decimal\",\"useGrouping\":false,\"maximumFractionDigits\":1}}},{\"columnMatch\":\"Ready\",\"formatter\":18,\"formatOptions\":{\"thresholdsOptions\":\"icons\",\"thresholdsGrid\":[{\"operator\":\"==\",\"thresholdValue\":\"100\",\"representation\":\"success\",\"text\":\"{0}{1}\"},{\"operator\":\"==\",\"thresholdValue\":\"NaN\",\"representation\":\"more\",\"text\":\"{0}{1}\"},{\"operator\":\"Default\",\"thresholdValue\":null,\"representation\":\"2\",\"text\":\"{0}{1}\"}]},\"numberFormat\":{\"unit\":1,\"options\":{\"style\":\"decimal\",\"useGrouping\":false,\"maximumFractionDigits\":1}}},{\"columnMatch\":\"ReadyTrend\",\"formatter\":9,\"formatOptions\":{\"min\":0,\"max\":100,\"palette\":\"redGreen\"}},{\"columnMatch\":\"Updated\",\"formatter\":18,\"formatOptions\":{\"thresholdsOptions\":\"icons\",\"thresholdsGrid\":[{\"operator\":\"==\",\"thresholdValue\":\"100\",\"representation\":\"success\",\"text\":\"{0}{1}\"},{\"operator\":\"==\",\"thresholdValue\":\"NaN\",\"representation\":\"more\",\"text\":\"{0}{1}\"},{\"operator\":\"Default\",\"thresholdValue\":null,\"representation\":\"warning\",\"text\":\"{0}{1}\"}]},\"numberFormat\":{\"unit\":1,\"options\":{\"style\":\"decimal\",\"maximumFractionDigits\":1}}},{\"columnMatch\":\"UpdatedTrend\",\"formatter\":9,\"formatOptions\":{\"min\":0,\"max\":100,\"palette\":\"redGreen\"}},{\"columnMatch\":\"Available\",\"formatter\":18,\"formatOptions\":{\"thresholdsOptions\":\"icons\",\"thresholdsGrid\":[{\"operator\":\"==\",\"thresholdValue\":\"100\",\"representation\":\"success\",\"text\":\"{0}{1}\"},{\"operator\":\"==\",\"thresholdValue\":\"NaN\",\"representation\":\"more\",\"text\":\"{0}{1}\"},{\"operator\":\"Default\",\"thresholdValue\":null,\"representation\":\"warning\",\"text\":\"{0}{1}\"}]},\"numberFormat\":{\"unit\":1,\"options\":{\"style\":\"decimal\",\"maximumFractionDigits\":1}}},{\"columnMatch\":\"AvailableTrend\",\"formatter\":9,\"formatOptions\":{\"min\":0,\"max\":100,\"palette\":\"redGreen\"}}],\"filter\":true,\"sortBy\":[{\"itemKey\":\"Deployment\",\"sortOrder\":2}],\"labelSettings\":[{\"columnId\":\"Updated\",\"label\":\"Up-to-date\"},{\"columnId\":\"UpdatedTrend\",\"label\":\"Up-to-dateTrend\"}]},\"sortBy\":[{\"itemKey\":\"Deployment\",\"sortOrder\":2}],\"tileSettings\":{\"titleContent\":{\"columnMatch\":\"Ready\",\"formatter\":18,\"formatOptions\":{\"thresholdsOptions\":\"colors\",\"thresholdsGrid\":[{\"operator\":\"==\",\"thresholdValue\":\"1\",\"representation\":null,\"text\":\"{0}{1}\"},{\"operator\":\"Default\",\"thresholdValue\":null,\"representation\":null,\"text\":\"{0}{1}\"}]}},\"showBorder\":false}}",
                "isOptional": true
              },
              {
                "name": "ParameterValues",
                "value": {
                  "timeRange": {
                    "type": 4,
                    "value": {
                      "durationMs": 21600000
                    },
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "Last 6 hours",
                    "displayName": "Time Range",
                    "formattedValue": "Last 6 hours"
                  },
                  "resource": {
                    "type": 5,
                    "value": "${kubernetes_id}",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "Any one",
                    "displayName": "resource",
                    "specialValue": "value::1",
                    "formattedValue": "${kubernetes_id}"
                  },
                  "resourceType": {
                    "type": 7,
                    "value": "microsoft.containerservice/managedclusters",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "Any one",
                    "displayName": "resourceType",
                    "specialValue": "value::1",
                    "formattedValue": "microsoft.containerservice/managedclusters"
                  },
                  "clusterId": {
                    "type": 1,
                    "value": "${kubernetes_id}",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "${kubernetes_id}",
                    "displayName": "clusterId",
                    "formattedValue": "${kubernetes_id}"
                  },
                  "clusterIdWhereClause": {
                    "type": 1,
                    "value": "| where \"a\" == \"a\"",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "| where \"a\" == \"a\"",
                    "displayName": "clusterIdWhereClause",
                    "formattedValue": "| where \"a\" == \"a\""
                  },
                  "namespace": {
                    "type": 2,
                    "value": [
                      "dapr-system",
                      "default",
                      "gatekeeper-system",
                      "kube-system",
                      "odx",
                      "core-services-ns"
                    ],
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "All",
                    "displayName": "Namespace",
                    "specialValue": [
                      "value::all"
                    ],
                    "formattedValue": "'dapr-system','default','gatekeeper-system','kube-system','odx','core-services-ns'"
                  },
                  "deploymentName": {
                    "type": 2,
                    "value": [
                      "dapr-dashboard",
                      "dapr-operator",
                      "dapr-sentry",
                      "dapr-sidecar-injector",
                      "aixs-connector-image-deployment",
                      "aixs-hdp-mock-deployment",
                      "aixs-hdp-mock-image-deployment",
                      "gatekeeper-audit",
                      "gatekeeper-controller",
                      "ama-logs-rs",
                      "azure-policy",
                      "azure-policy-webhook",
                      "coredns",
                      "coredns-autoscaler",
                      "extension-agent",
                      "extension-operator",
                      "konnectivity-agent",
                      "metrics-server",
                      "microsoft-defender-collector-misc",
                      "odx",
                      "core-hdp-observer"
                    ],
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "All",
                    "displayName": "Deployment",
                    "specialValue": [
                      "value::all"
                    ],
                    "formattedValue": "'dapr-dashboard','dapr-operator','dapr-sentry','dapr-sidecar-injector','aixs-connector-image-deployment','aixs-hdp-mock-deployment','aixs-hdp-mock-image-deployment','gatekeeper-audit','gatekeeper-controller','ama-logs-rs','azure-policy','azure-policy-webhook','coredns','coredns-autoscaler','extension-agent','extension-operator','konnectivity-agent','metrics-server','microsoft-defender-collector-misc','odx','core-hdp-observer'"
                  },
                  "hpa": {
                    "type": 2,
                    "value": [],
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "All",
                    "displayName": "HPA",
                    "specialValue": [
                      "value::all"
                    ],
                    "formattedValue": null
                  },
                  "selectedTab": {
                    "type": 1,
                    "value": "Deployment",
                    "formattedValue": "Deployment"
                  },
                  "OverallFilter": {
                    "value": "*",
                    "formattedValue": "*",
                    "labelValue": "*",
                    "type": 1
                  }
                },
                "isOptional": true
              },
              {
                "name": "Location",
                "isOptional": true
              }
            ],
            "type": "Extension/AppInsightsExtension/PartType/PinnedNotebookQueryPart"
          }
        },
        "15": {
          "position": {
            "x": 0,
            "y": 26,
            "colSpan": 18,
            "rowSpan": 3
          },
          "metadata": {
            "inputs": [
              {
                "name": "resourceTypeMode",
                "isOptional": true
              },
              {
                "name": "ComponentId",
                "isOptional": true
              },
              {
                "name": "Scope",
                "value": {
                  "resourceIds": [
                    "${log_analytics_workspace_id}"
                  ]
                },
                "isOptional": true
              },
              {
                "name": "PartId",
                "value": "7f60ff40-5210-4134-a404-a3b80683418f",
                "isOptional": true
              },
              {
                "name": "Version",
                "value": "2.0",
                "isOptional": true
              },
              {
                "name": "TimeRange",
                "value": "P1D",
                "isOptional": true
              },
              {
                "name": "DashboardId",
                "isOptional": true
              },
              {
                "name": "DraftRequestParameters",
                "isOptional": true
              },
              {
                "name": "Query",
                "value": "KubeEvents\n| take 1000\n| where not(isempty(Namespace))\n| sort by TimeGenerated desc\n| project TimeGenerated, Computer, Namespace, ObjectKind, PodName = Name, KubeEventType, Reason, Message\n| render table\n",
                "isOptional": true
              },
              {
                "name": "ControlType",
                "value": "AnalyticsGrid",
                "isOptional": true
              },
              {
                "name": "SpecificChart",
                "isOptional": true
              },
              {
                "name": "PartTitle",
                "value": "Analytics",
                "isOptional": true
              },
              {
                "name": "PartSubTitle",
                "value": "lws-mlif-dev-weus",
                "isOptional": true
              },
              {
                "name": "Dimensions",
                "isOptional": true
              },
              {
                "name": "LegendOptions",
                "isOptional": true
              },
              {
                "name": "IsQueryContainTimeRange",
                "value": false,
                "isOptional": true
              }
            ],
            "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
            "settings": {
              "content": {
                "GridColumnsWidth": {
                  "Message": "423px",
                  "ObjectKind": "117px",
                  "Namespace": "116px",
                  "Computer": "216px"
                }
              }
            }
          }
        },
        "16": {
          "position": {
            "x": 0,
            "y": 29,
            "colSpan": 18,
            "rowSpan": 1
          },
          "metadata": {
            "inputs": [],
            "type": "Extension/HubsExtension/PartType/MarkdownPart",
            "settings": {
              "content": {
                "content": "# ODX - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ",
                "title": "",
                "subtitle": "",
                "markdownSource": 1,
                "markdownUri": ""
              }
            }
          }
        },
        "17": {
          "position": {
            "x": 0,
            "y": 30,
            "colSpan": 18,
            "rowSpan": 3
          },
          "metadata": {
            "inputs": [
              {
                "name": "ComponentId",
                "value": "${kubernetes_id}",
                "isOptional": true
              },
              {
                "name": "TimeContext",
                "value": null,
                "isOptional": true
              },
              {
                "name": "ResourceIds",
                "value": [
                  "${kubernetes_id}"
                ],
                "isOptional": true
              },
              {
                "name": "ConfigurationId",
                "value": "Community-Workbooks/AKS/Deployments and HPAs",
                "isOptional": true
              },
              {
                "name": "Type",
                "value": "container-insights",
                "isOptional": true
              },
              {
                "name": "GalleryResourceType",
                "value": "microsoft.containerservice/managedclusters",
                "isOptional": true
              },
              {
                "name": "PinName",
                "value": "Deployments",
                "isOptional": true
              },
              {
                "name": "StepSettings",
                "value": "{\"version\":\"KqlItem/1.0\",\"query\":\"let data = materialize(\\r\\nInsightsMetrics\\r\\n| where Name == \\\"kube_deployment_status_replicas_ready\\\"\\r\\n| extend Tags = parse_json(Tags)\\r\\n| extend ClusterId = Tags[\\\"container.azm.ms/clusterId\\\"]\\r\\n{clusterIdWhereClause}\\r\\n| where Tags.deployment in ({deploymentName})\\r\\n| extend Deployment = tostring(Tags.deployment)\\r\\n| extend k8sNamespace = tostring(Tags.k8sNamespace)\\r\\n| extend Ready = Val/Tags.spec_replicas * 100, Updated = Val/Tags.status_replicas_updated * 100, Available = Val/Tags.status_replicas_available * 100\\r\\n| project k8sNamespace, Deployment, Ready, Updated, Available, TimeGenerated, Tags\\r\\n);\\r\\nlet data2 = data\\r\\n| extend Age = (now() - todatetime(Tags[\\\"creationTime\\\"]))/1m\\r\\n| summarize arg_max(TimeGenerated, *) by k8sNamespace, Deployment\\r\\n| project k8sNamespace, Deployment, Age, Ready, Updated, Available;\\r\\nlet ReadyData = data\\r\\n| make-series ReadyTrend = avg(Ready) default = 0 on TimeGenerated from {timeRange:start} to {timeRange:end} step {timeRange:grain} by k8sNamespace, Deployment;\\r\\nlet UpdatedData = data\\r\\n| make-series UpdatedTrend = avg(Updated) default = 0 on TimeGenerated from {timeRange:start} to {timeRange:end} step {timeRange:grain} by k8sNamespace, Deployment;\\r\\nlet AvailableData = data\\r\\n| make-series AvailableTrend = avg(Available) default = 0 on TimeGenerated from {timeRange:start} to {timeRange:end} step {timeRange:grain} by k8sNamespace, Deployment;\\r\\ndata2\\r\\n| join kind = inner(ReadyData) on k8sNamespace, Deployment \\r\\n| join kind = inner(UpdatedData) on k8sNamespace, Deployment \\r\\n| join kind = inner(AvailableData) on k8sNamespace, Deployment\\r\\n| extend ReadyCase = case(Ready == 100, \\\"Healthy\\\", \\\"Warning\\\"),  UpdatedCase = case(Updated == 100, \\\"Healthy\\\", \\\"Warning\\\"),  AvailableCase = case(Available == 100, \\\"Healthy\\\", \\\"Warning\\\")\\r\\n| extend Overall = case(ReadyCase == \\\"Healthy\\\" and UpdatedCase == \\\"Healthy\\\" and AvailableCase == \\\"Healthy\\\", \\\"Healthy\\\", \\\"Warning\\\")\\r\\n| extend OverallFilterStatus = case('{OverallFilter}' contains \\\"Healthy\\\", \\\"Healthy\\\", '{OverallFilter}' contains \\\"Warning\\\", \\\"Warning\\\", \\\"Healthy, Warning\\\")\\r\\n| where OverallFilterStatus has Overall\\r\\n| project Deployment, Namespace = k8sNamespace, Age, Ready, ReadyTrend, Updated, UpdatedTrend, Available,AvailableTrend\\r\\n| sort by Ready asc\\r\\n\",\"size\":0,\"showAnalytics\":true,\"timeContext\":{\"durationMs\":86400000},\"showExportToExcel\":true,\"queryType\":0,\"resourceType\":\"{resourceType}\",\"crossComponentResources\":[\"{resource}\"],\"visualization\":\"table\",\"gridSettings\":{\"formatters\":[{\"columnMatch\":\"Age\",\"formatter\":0,\"numberFormat\":{\"unit\":25,\"options\":{\"style\":\"decimal\",\"useGrouping\":false,\"maximumFractionDigits\":1}}},{\"columnMatch\":\"Ready\",\"formatter\":18,\"formatOptions\":{\"thresholdsOptions\":\"icons\",\"thresholdsGrid\":[{\"operator\":\"==\",\"thresholdValue\":\"100\",\"representation\":\"success\",\"text\":\"{0}{1}\"},{\"operator\":\"==\",\"thresholdValue\":\"NaN\",\"representation\":\"more\",\"text\":\"{0}{1}\"},{\"operator\":\"Default\",\"thresholdValue\":null,\"representation\":\"2\",\"text\":\"{0}{1}\"}]},\"numberFormat\":{\"unit\":1,\"options\":{\"style\":\"decimal\",\"useGrouping\":false,\"maximumFractionDigits\":1}}},{\"columnMatch\":\"ReadyTrend\",\"formatter\":9,\"formatOptions\":{\"min\":0,\"max\":100,\"palette\":\"redGreen\"}},{\"columnMatch\":\"Updated\",\"formatter\":18,\"formatOptions\":{\"thresholdsOptions\":\"icons\",\"thresholdsGrid\":[{\"operator\":\"==\",\"thresholdValue\":\"100\",\"representation\":\"success\",\"text\":\"{0}{1}\"},{\"operator\":\"==\",\"thresholdValue\":\"NaN\",\"representation\":\"more\",\"text\":\"{0}{1}\"},{\"operator\":\"Default\",\"thresholdValue\":null,\"representation\":\"warning\",\"text\":\"{0}{1}\"}]},\"numberFormat\":{\"unit\":1,\"options\":{\"style\":\"decimal\",\"maximumFractionDigits\":1}}},{\"columnMatch\":\"UpdatedTrend\",\"formatter\":9,\"formatOptions\":{\"min\":0,\"max\":100,\"palette\":\"redGreen\"}},{\"columnMatch\":\"Available\",\"formatter\":18,\"formatOptions\":{\"thresholdsOptions\":\"icons\",\"thresholdsGrid\":[{\"operator\":\"==\",\"thresholdValue\":\"100\",\"representation\":\"success\",\"text\":\"{0}{1}\"},{\"operator\":\"==\",\"thresholdValue\":\"NaN\",\"representation\":\"more\",\"text\":\"{0}{1}\"},{\"operator\":\"Default\",\"thresholdValue\":null,\"representation\":\"warning\",\"text\":\"{0}{1}\"}]},\"numberFormat\":{\"unit\":1,\"options\":{\"style\":\"decimal\",\"maximumFractionDigits\":1}}},{\"columnMatch\":\"AvailableTrend\",\"formatter\":9,\"formatOptions\":{\"min\":0,\"max\":100,\"palette\":\"redGreen\"}}],\"filter\":true,\"sortBy\":[{\"itemKey\":\"Deployment\",\"sortOrder\":2}],\"labelSettings\":[{\"columnId\":\"Updated\",\"label\":\"Up-to-date\"},{\"columnId\":\"UpdatedTrend\",\"label\":\"Up-to-dateTrend\"}]},\"sortBy\":[{\"itemKey\":\"Deployment\",\"sortOrder\":2}],\"tileSettings\":{\"titleContent\":{\"columnMatch\":\"Ready\",\"formatter\":18,\"formatOptions\":{\"thresholdsOptions\":\"colors\",\"thresholdsGrid\":[{\"operator\":\"==\",\"thresholdValue\":\"1\",\"representation\":null,\"text\":\"{0}{1}\"},{\"operator\":\"Default\",\"thresholdValue\":null,\"representation\":null,\"text\":\"{0}{1}\"}]}},\"showBorder\":false}}",
                "isOptional": true
              },
              {
                "name": "ParameterValues",
                "value": {
                  "timeRange": {
                    "type": 4,
                    "value": {
                      "durationMs": 21600000
                    },
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "Last 6 hours",
                    "displayName": "Time Range",
                    "formattedValue": "Last 6 hours"
                  },
                  "resource": {
                    "type": 5,
                    "value": "${kubernetes_id}",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "Any one",
                    "displayName": "resource",
                    "specialValue": "value::1",
                    "formattedValue": "${kubernetes_id}"
                  },
                  "resourceType": {
                    "type": 7,
                    "value": "microsoft.containerservice/managedclusters",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "Any one",
                    "displayName": "resourceType",
                    "specialValue": "value::1",
                    "formattedValue": "microsoft.containerservice/managedclusters"
                  },
                  "clusterId": {
                    "type": 1,
                    "value": "${kubernetes_id}",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "${kubernetes_id}",
                    "displayName": "clusterId",
                    "formattedValue": "${kubernetes_id}"
                  },
                  "clusterIdWhereClause": {
                    "type": 1,
                    "value": "| where \"a\" == \"a\"",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "| where \"a\" == \"a\"",
                    "displayName": "clusterIdWhereClause",
                    "formattedValue": "| where \"a\" == \"a\""
                  },
                  "namespace": {
                    "type": 2,
                    "value": [
                      "odx"
                    ],
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "odx",
                    "displayName": "Namespace",
                    "formattedValue": "'odx'"
                  },
                  "deploymentName": {
                    "type": 2,
                    "value": [
                      "odx"
                    ],
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "All",
                    "displayName": "Deployment",
                    "specialValue": [
                      "value::all"
                    ],
                    "formattedValue": "'odx'"
                  },
                  "hpa": {
                    "type": 2,
                    "value": [],
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "All",
                    "displayName": "HPA",
                    "specialValue": [
                      "value::all"
                    ],
                    "formattedValue": null
                  },
                  "selectedTab": {
                    "type": 1,
                    "value": "Deployment",
                    "formattedValue": "Deployment"
                  },
                  "OverallFilter": {
                    "value": "*",
                    "formattedValue": "*",
                    "labelValue": "*",
                    "type": 1
                  }
                },
                "isOptional": true
              },
              {
                "name": "Location",
                "isOptional": true
              }
            ],
            "type": "Extension/AppInsightsExtension/PartType/PinnedNotebookQueryPart"
          }
        },
        "18": {
          "position": {
            "x": 0,
            "y": 33,
            "colSpan": 6,
            "rowSpan": 5
          },
          "metadata": {
            "inputs": [
              {
                "name": "ComponentId",
                "value": "${kubernetes_id}",
                "isOptional": true
              },
              {
                "name": "TimeContext",
                "value": null,
                "isOptional": true
              },
              {
                "name": "ResourceIds",
                "value": [
                  "${kubernetes_id}"
                ],
                "isOptional": true
              },
              {
                "name": "ConfigurationId",
                "value": "Community-Workbooks/AKS/Workload Details Divided",
                "isOptional": true
              },
              {
                "name": "Type",
                "value": "container-insights",
                "isOptional": true
              },
              {
                "name": "GalleryResourceType",
                "value": "microsoft.containerservice/managedclusters",
                "isOptional": true
              },
              {
                "name": "PinName",
                "value": "Workload Details",
                "isOptional": true
              },
              {
                "name": "StepSettings",
                "value": "{\"version\":\"KqlItem/1.0\",\"query\":\"let endDateTime = {timeRange:end};\\r\\nlet startDateTime = {timeRange:start};\\r\\nlet trendBinSize = {timeRange:grain};\\r\\nlet capacityCounterName = 'cpuLimitNanoCores';\\r\\nlet usageCounterName = 'cpuUsageNanoCores';\\r\\nlet controllerName= '{workloadName}';\\r\\nKubePodInventory\\r\\n| where TimeGenerated < endDateTime\\r\\n| where TimeGenerated >= startDateTime\\r\\n{clusterIdWhereClause}\\r\\n{workloadKindWhereClause}\\r\\n{namespaceWhereClause}\\r\\n| where ControllerName in  (controllerName)\\r\\n| extend InstanceName = strcat(ClusterId, '/', ContainerName),\\r\\n         ContainerName = strcat(controllerName, '/', tostring(split(ContainerName, '/')[1])),\\r\\n         PodName = Name\\r\\n{podStatusWhereClause}\\r\\n{podNameWhereClause}\\r\\n| distinct Computer, InstanceName, ContainerName\\r\\n| join hint.strategy=shuffle (\\r\\n    Perf\\r\\n    | where TimeGenerated < endDateTime\\r\\n    | where TimeGenerated >= startDateTime\\r\\n    | where ObjectName == 'K8SContainer'\\r\\n    | where CounterName == capacityCounterName\\r\\n    | summarize LimitValue = max(CounterValue) by Computer, InstanceName, bin(TimeGenerated, trendBinSize)\\r\\n    | project Computer, InstanceName, LimitStartTime = TimeGenerated, LimitEndTime = TimeGenerated + trendBinSize, LimitValue, limitA=100\\r\\n) on Computer, InstanceName\\r\\n| join kind=inner hint.strategy=shuffle (\\r\\n    Perf\\r\\n    | where TimeGenerated < endDateTime + trendBinSize\\r\\n    | where TimeGenerated >= startDateTime - trendBinSize\\r\\n    | where ObjectName == 'K8SContainer'\\r\\n    | where CounterName == usageCounterName\\r\\n    | project Computer, InstanceName, UsageValue = CounterValue, limit=100, TimeGenerated\\r\\n) on Computer, InstanceName\\r\\n| where TimeGenerated >= LimitStartTime and TimeGenerated < LimitEndTime\\r\\n| project  ContainerName, TimeGenerated, UsagePercent = UsageValue * 100.0 / LimitValue \\r\\n| summarize AggregatedValue=max(UsagePercent) by bin(TimeGenerated, trendBinSize), ContainerName\",\"size\":0,\"aggregation\":2,\"showAnalytics\":true,\"title\":\"Max CPU Usage by Pods\",\"timeContextFromParameter\":\"timeRange\",\"queryType\":0,\"resourceType\":\"{resourceType}\",\"crossComponentResources\":[\"{resource}\"],\"visualization\":\"timechart\",\"chartSettings\":{\"ySettings\":{\"unit\":1,\"min\":null,\"max\":null}}}",
                "isOptional": true
              },
              {
                "name": "ParameterValues",
                "value": {
                  "timeRange": {
                    "type": 4,
                    "value": {
                      "durationMs": 21600000
                    },
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "Last 6 hours",
                    "displayName": "Time Range",
                    "formattedValue": "Last 6 hours"
                  },
                  "resource": {
                    "type": 5,
                    "value": "${kubernetes_id}",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "Any one",
                    "displayName": "resource",
                    "specialValue": "value::1",
                    "formattedValue": "${kubernetes_id}"
                  },
                  "resourceType": {
                    "type": 7,
                    "value": "microsoft.containerservice/managedclusters",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "Any one",
                    "displayName": "resourceType",
                    "specialValue": "value::1",
                    "formattedValue": "microsoft.containerservice/managedclusters"
                  },
                  "clusterId": {
                    "type": 1,
                    "value": "${kubernetes_id}",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "${kubernetes_id}",
                    "displayName": "clusterId",
                    "formattedValue": "${kubernetes_id}"
                  },
                  "clusterIdWhereClause": {
                    "type": 1,
                    "value": "| where \"a\" == \"a\"",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "| where \"a\" == \"a\"",
                    "displayName": "clusterIdWhereClause",
                    "formattedValue": "| where \"a\" == \"a\""
                  },
                  "workloadType": {
                    "type": 2,
                    "value": [
                      "DaemonSet",
                      "ReplicaSet",
                      "StatefulSet"
                    ],
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "All",
                    "displayName": "Workload Type",
                    "specialValue": [
                      "value::all"
                    ],
                    "formattedValue": "'DaemonSet','ReplicaSet','StatefulSet'"
                  },
                  "workloadKindWhereClause": {
                    "type": 1,
                    "value": "| where ControllerKind in ('DaemonSet','ReplicaSet','StatefulSet')",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "| where ControllerKind in ('DaemonSet','ReplicaSet','StatefulSet')",
                    "displayName": "workloadKindWhereClause",
                    "formattedValue": "| where ControllerKind in ('DaemonSet','ReplicaSet','StatefulSet')"
                  },
                  "namespace": {
                    "type": 2,
                    "value": [
                      "odx"
                    ],
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "odx",
                    "displayName": "Namespace",
                    "formattedValue": "'odx'"
                  },
                  "namespaceWhereClause": {
                    "type": 1,
                    "value": "| where Namespace in ('odx')",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "| where Namespace in ('odx')",
                    "displayName": "namespaceWhereClause",
                    "formattedValue": "| where Namespace in ('odx')"
                  },
                  "workloadName": {
                    "type": 2,
                    "value": "odx-58b795d6c8",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "Any one",
                    "displayName": "Workload Name",
                    "specialValue": "value::1",
                    "formattedValue": "odx-58b795d6c8"
                  },
                  "podStatus": {
                    "type": 2,
                    "value": [
                      "Running"
                    ],
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "All",
                    "displayName": "Pod Status",
                    "specialValue": [
                      "value::all"
                    ],
                    "formattedValue": "'Running'"
                  },
                  "podStatusWhereClause": {
                    "type": 1,
                    "value": "| where PodStatus in ('Running')",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "| where PodStatus in ('Running')",
                    "displayName": "podStatusWhereClause",
                    "formattedValue": "| where PodStatus in ('Running')"
                  },
                  "podName": {
                    "type": 2,
                    "value": [
                      "odx-58b795d6c8-7w5jb"
                    ],
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "All",
                    "displayName": "Pod Name",
                    "specialValue": [
                      "value::all"
                    ],
                    "formattedValue": "'odx-58b795d6c8-7w5jb'"
                  },
                  "podNameWhereClause": {
                    "type": 1,
                    "value": "| where PodName in ('odx-58b795d6c8-7w5jb')",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "| where PodName in ('odx-58b795d6c8-7w5jb')",
                    "displayName": "podNameWhereClause",
                    "formattedValue": "| where PodName in ('odx-58b795d6c8-7w5jb')"
                  },
                  "workloadNamespaceText": {
                    "type": 1,
                    "value": "odx",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "odx",
                    "displayName": "workloadNamespaceText",
                    "formattedValue": "odx"
                  },
                  "workloadTypeText": {
                    "type": 1,
                    "value": "ReplicaSet",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "ReplicaSet",
                    "displayName": "workloadTypeText",
                    "formattedValue": "ReplicaSet"
                  },
                  "selectedTab": {
                    "type": 1,
                    "value": "Overview",
                    "formattedValue": "Overview"
                  }
                },
                "isOptional": true
              },
              {
                "name": "Location",
                "isOptional": true
              }
            ],
            "type": "Extension/AppInsightsExtension/PartType/PinnedNotebookQueryPart"
          }
        },
        "19": {
          "position": {
            "x": 6,
            "y": 33,
            "colSpan": 6,
            "rowSpan": 5
          },
          "metadata": {
            "inputs": [
              {
                "name": "ComponentId",
                "value": "${kubernetes_id}",
                "isOptional": true
              },
              {
                "name": "TimeContext",
                "value": null,
                "isOptional": true
              },
              {
                "name": "ResourceIds",
                "value": [
                  "${kubernetes_id}"
                ],
                "isOptional": true
              },
              {
                "name": "ConfigurationId",
                "value": "Community-Workbooks/AKS/Workload Details Divided",
                "isOptional": true
              },
              {
                "name": "Type",
                "value": "container-insights",
                "isOptional": true
              },
              {
                "name": "GalleryResourceType",
                "value": "microsoft.containerservice/managedclusters",
                "isOptional": true
              },
              {
                "name": "PinName",
                "value": "Workload Details",
                "isOptional": true
              },
              {
                "name": "StepSettings",
                "value": "{\"version\":\"KqlItem/1.0\",\"query\":\"let endDateTime = {timeRange:end};\\r\\nlet startDateTime = {timeRange:start};\\r\\nlet trendBinSize = {timeRange:grain};\\r\\nlet capacityCounterName = 'memoryLimitBytes';\\r\\nlet usageCounterName = 'memoryWorkingSetBytes';\\r\\nlet controllerName= '{workloadName:value}';\\r\\nKubePodInventory\\r\\n| where TimeGenerated < endDateTime\\r\\n| where TimeGenerated >= startDateTime\\r\\n{clusterIdWhereClause}\\r\\n{workloadKindWhereClause}\\r\\n{namespaceWhereClause}\\r\\n| where ControllerName == controllerName\\r\\n| extend InstanceName = strcat(ClusterId, '/', ContainerName),\\r\\n         ContainerName = strcat(controllerName, '/', tostring(split(ContainerName, '/')[1])),\\r\\n         PodName=Name\\r\\n{podStatusWhereClause}\\r\\n{podNameWhereClause}\\r\\n| distinct Computer, InstanceName, ContainerName\\r\\n| join hint.strategy=shuffle (\\r\\n    Perf\\r\\n    | where TimeGenerated < endDateTime\\r\\n    | where TimeGenerated >= startDateTime\\r\\n    | where ObjectName == 'K8SContainer'\\r\\n    | where CounterName == capacityCounterName\\r\\n    | summarize LimitValue = max(CounterValue) by Computer, InstanceName, bin(TimeGenerated, trendBinSize)\\r\\n    | project Computer, InstanceName, LimitStartTime = TimeGenerated, LimitEndTime = TimeGenerated + trendBinSize, LimitValue\\r\\n) on Computer, InstanceName\\r\\n| join kind=inner hint.strategy=shuffle (\\r\\n    Perf\\r\\n    | where TimeGenerated < endDateTime + trendBinSize\\r\\n    | where TimeGenerated >= startDateTime - trendBinSize\\r\\n    | where ObjectName == 'K8SContainer'\\r\\n    | where CounterName == usageCounterName\\r\\n    | project Computer, InstanceName, UsageValue = CounterValue, TimeGenerated\\r\\n) on Computer, InstanceName\\r\\n| where TimeGenerated >= LimitStartTime and TimeGenerated < LimitEndTime\\r\\n| project Computer, ContainerName, TimeGenerated, UsagePercent = UsageValue * 100.0 / LimitValue\\r\\n| summarize AggregatedValue = max(UsagePercent) by bin(TimeGenerated, trendBinSize) , ContainerName\\r\\n\",\"size\":0,\"aggregation\":2,\"showAnalytics\":true,\"title\":\"Max Memory Usage ( Working Set ) by Pods\",\"timeContextFromParameter\":\"timeRange\",\"queryType\":0,\"resourceType\":\"{resourceType}\",\"crossComponentResources\":[\"{resource}\"],\"visualization\":\"timechart\",\"chartSettings\":{\"ySettings\":{\"unit\":1,\"min\":null,\"max\":null}}}",
                "isOptional": true
              },
              {
                "name": "ParameterValues",
                "value": {
                  "timeRange": {
                    "type": 4,
                    "value": {
                      "durationMs": 21600000
                    },
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "Last 6 hours",
                    "displayName": "Time Range",
                    "formattedValue": "Last 6 hours"
                  },
                  "resource": {
                    "type": 5,
                    "value": "${kubernetes_id}",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "Any one",
                    "displayName": "resource",
                    "specialValue": "value::1",
                    "formattedValue": "${kubernetes_id}"
                  },
                  "resourceType": {
                    "type": 7,
                    "value": "microsoft.containerservice/managedclusters",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "Any one",
                    "displayName": "resourceType",
                    "specialValue": "value::1",
                    "formattedValue": "microsoft.containerservice/managedclusters"
                  },
                  "clusterId": {
                    "type": 1,
                    "value": "${kubernetes_id}",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "${kubernetes_id}",
                    "displayName": "clusterId",
                    "formattedValue": "${kubernetes_id}"
                  },
                  "clusterIdWhereClause": {
                    "type": 1,
                    "value": "| where \"a\" == \"a\"",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "| where \"a\" == \"a\"",
                    "displayName": "clusterIdWhereClause",
                    "formattedValue": "| where \"a\" == \"a\""
                  },
                  "workloadType": {
                    "type": 2,
                    "value": [
                      "DaemonSet",
                      "ReplicaSet",
                      "StatefulSet"
                    ],
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "All",
                    "displayName": "Workload Type",
                    "specialValue": [
                      "value::all"
                    ],
                    "formattedValue": "'DaemonSet','ReplicaSet','StatefulSet'"
                  },
                  "workloadKindWhereClause": {
                    "type": 1,
                    "value": "| where ControllerKind in ('DaemonSet','ReplicaSet','StatefulSet')",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "| where ControllerKind in ('DaemonSet','ReplicaSet','StatefulSet')",
                    "displayName": "workloadKindWhereClause",
                    "formattedValue": "| where ControllerKind in ('DaemonSet','ReplicaSet','StatefulSet')"
                  },
                  "namespace": {
                    "type": 2,
                    "value": [
                      "odx"
                    ],
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "odx",
                    "displayName": "Namespace",
                    "formattedValue": "'odx'"
                  },
                  "namespaceWhereClause": {
                    "type": 1,
                    "value": "| where Namespace in ('odx')",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "| where Namespace in ('odx')",
                    "displayName": "namespaceWhereClause",
                    "formattedValue": "| where Namespace in ('odx')"
                  },
                  "workloadName": {
                    "type": 2,
                    "value": "odx-58b795d6c8",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "Any one",
                    "displayName": "Workload Name",
                    "specialValue": "value::1",
                    "formattedValue": "odx-58b795d6c8"
                  },
                  "podStatus": {
                    "type": 2,
                    "value": [
                      "Running"
                    ],
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "All",
                    "displayName": "Pod Status",
                    "specialValue": [
                      "value::all"
                    ],
                    "formattedValue": "'Running'"
                  },
                  "podStatusWhereClause": {
                    "type": 1,
                    "value": "| where PodStatus in ('Running')",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "| where PodStatus in ('Running')",
                    "displayName": "podStatusWhereClause",
                    "formattedValue": "| where PodStatus in ('Running')"
                  },
                  "podName": {
                    "type": 2,
                    "value": [
                      "odx-58b795d6c8-7w5jb"
                    ],
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "All",
                    "displayName": "Pod Name",
                    "specialValue": [
                      "value::all"
                    ],
                    "formattedValue": "'odx-58b795d6c8-7w5jb'"
                  },
                  "podNameWhereClause": {
                    "type": 1,
                    "value": "| where PodName in ('odx-58b795d6c8-7w5jb')",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "| where PodName in ('odx-58b795d6c8-7w5jb')",
                    "displayName": "podNameWhereClause",
                    "formattedValue": "| where PodName in ('odx-58b795d6c8-7w5jb')"
                  },
                  "workloadNamespaceText": {
                    "type": 1,
                    "value": "odx",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "odx",
                    "displayName": "workloadNamespaceText",
                    "formattedValue": "odx"
                  },
                  "workloadTypeText": {
                    "type": 1,
                    "value": "ReplicaSet",
                    "isPending": false,
                    "isWaiting": false,
                    "isFailed": false,
                    "isGlobal": false,
                    "labelValue": "ReplicaSet",
                    "displayName": "workloadTypeText",
                    "formattedValue": "ReplicaSet"
                  },
                  "selectedTab": {
                    "type": 1,
                    "value": "Overview",
                    "formattedValue": "Overview"
                  }
                },
                "isOptional": true
              },
              {
                "name": "Location",
                "isOptional": true
              }
            ],
            "type": "Extension/AppInsightsExtension/PartType/PinnedNotebookQueryPart"
          }
        }
      }
    }
  },
  "metadata": {
    "model": {
      "timeRange": {
        "value": {
          "relative": {
            "duration": 24,
            "timeUnit": 1
          }
        },
        "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
      }
    }
  }
}