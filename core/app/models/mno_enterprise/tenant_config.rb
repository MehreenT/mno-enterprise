# frozen_string_literal: true
module MnoEnterprise
  # Frontend configuration management
  class TenantConfig
    # == Constants ============================================================
    # JSON schema for the configuration
    # This is used to provide default values and to generate the form in the frontend
    # This *MUST* be updated any time a new feature flag is added
    CONFIG_JSON_SCHEMA = {
      '$schema': "http://json-schema.org/draft-04/schema#",
      type: "object",
      title: "Settings",
      properties: {
        system: {
          type: "object",
          description: "System Settings",
          properties: {
            app_name: {
              type: "string",
              description: "Application Name",
              default: "My Company"
            },
            smtp: {
              description: "SMTP Settings",
              type: "object",
              properties: {
                authentication: {
                  type: "string",
                  description: "Mail server authentication type",
                  default: "plain",
                  "enum": ["plain", "login", "cram_md5"]
                },
                address: {
                  type: "string",
                  description: "Mail server address",
                  default: "localhost"
                },
                port: {
                  type: "integer",
                  description: "Mail server port",
                  default: 25
                },
                domain: {
                  type: "string",
                  description: "HELO domain"
                },
                user_name: {
                  type: "string",
                  description: "Mail username"
                },
                password: {
                  type: "string",
                  description: "Mail password"
                }
              }
            },
            email: {
              type: "object",
              description: "System email settings",
              properties: {
                support_email: {
                  type: "string",
                  description: "Support email address. Displayed in the frontend",
                  default: "support@example.com"
                },
                default_sender: {
                  type: "object",
                  description: "Default sender for system generated emails",
                  properties: {
                    email: {
                      type: "string",
                      # description: "Default sender email for system generated emails",
                      default: "no-reply@example.com"
                    },
                    name: {
                      type: "string",
                      # description: "Default sender name for system generated emails",
                      default: "no-reply@example.com"
                    }
                  }
                }
              }
            },
            i18n: {
              type: "object",
              description: "Internationalization settings",
              properties: {
                enabled: {
                  type: "boolean",
                  description: "Enable internationalization",
                  default: false
                }
              }
            }
          }
        },
        dashboard: {
          type: "object",
          description: "Dashboard settings",
          properties: {
            audit_log: {
              type: "object",
              properties: {
                enabled: {
                  type: "boolean",
                  description: "Display Audit Log in Organization Panel",
                  default: false,
                  readonly: true
                }
              }
            },
            developer: {
              type: "object",
              properties: {
                enabled: {
                  type: "boolean",
                  description: "Display the Developer section on \"My Account\"",
                  default: false
                }
              }
            },
            dock: {
              type: "object",
              properties: {
                enabled: {
                  type: "boolean",
                  description: "Enable the App Dock",
                  default: true
                }
              }
            },
            marketplace: {
              type: "object",
              description: "Marketplace configuration",
              properties: {
                enabled: {
                  type: "boolean",
                  default: true,
                  description: "Enable the marketplace"
                },
                comparison: {
                  type: "object",
                  properties: {
                    enabled: {
                      type: "boolean",
                      default: false,
                      description: "Enable comparison of apps"
                    }
                  }
                },
                pricing: {
                  type: "object",
                  properties: {
                    enabled: {
                      type: "boolean",
                      description: "Display App Pricing on Marketplace",
                      default: true
                    },
                    # currency: {
                    #   type: "string",
                    #   description: "Currency to display price in",
                    #   default: "AUD"
                    # }
                  }
                },
                reviews: {
                  type: "object",
                  properties: {
                    enabled: {
                      type: "boolean",
                      default: false,
                      description: "Enable app reviews on the marketplace"
                    }
                  }
                },
              }
            },
            onboarding_wizard: {
              type: "object",
              properties: {
                enabled: {
                  type: "boolean",
                  default: false,
                  description: "Enable the onboarding wizard"
                }
              }
            },
            organization_management: {
              type: "object",
              properties: {
                enabled: {
                  type: "boolean",
                  default: true,
                  description: "Allow user to create and manage Organizations",
                },
                billing: {
                  type: "object",
                  properties: {
                    enabled: {
                      type: "boolean",
                      default: true,
                      description: "Display the billing tab"
                    }
                  }
                }
              }
            },
            # TODO: break - changed  disabled to enabled
            payment: {
              type: "object",
              properties: {
                enabled: {
                  type: "boolean",
                  default: true
                }
              }
            },
            registration: {
              type: "object",
              properties: {
                enabled:  {
                  type: "boolean",
                  description: "Enable user registration",
                  default: true
                }
              }
            },
            user_management: {
              type: "object",
              properties: {
                enabled: {
                  type: "boolean",
                  default: true,
                  description: "Allow user to edit their information and password"
                }
              }
            },

          }
        },
        admin_panel: {
          description: "Admin Panel Settings",
          type: "object",
          properties: {
            apps_management: {
              type: "object",
              properties: {
                enabled: {
                  type: "boolean",
                  default: true
                }
              }
            },
            audit_log: {
              type: "object",
              properties: {
                enabled: {
                  type: "boolean",
                  description: "Enable the audit log",
                  default: true
                }
              }
            },
            customer_management: {
              type: "object",
              properties: {
                organization: {
                  type: "object",
                  properties: {
                    enabled: {
                      type: "boolean",
                      default: true
                    }
                  }
                },
                user: {
                  type: "object",
                  properties: {
                    enabled: {
                      type: "boolean",
                      default: true
                    }
                  }
                }
              }
            },
            finance: {
              type: "object",
              properties: {
                enabled: {
                  type: "boolean",
                  default: true,
                  description: "disable the finance page, the financial kpis and the invoices in the admin panel"
                }
              }
            },
            impersonation: {
              type: "object",
              properties: {
                enabled: {
                  type: "boolean",
                  default: true
                }
              }
            },
            staff: {
              type: "object",
              properties: {
                enabled: {
                  type: "boolean",
                  default: true
                }
              }
            }
          }
        }
      }
    }.with_indifferent_access.freeze

    # == Extensions ===========================================================

    # == Callbacks ============================================================

    # == Class Methods ========================================================
    # @return [Hash] Config hash
    def self.to_hash
      build_object(CONFIG_JSON_SCHEMA)
    end

    # Render a YAML representation of the config
    # Mostly used for debugging purppose
    # @return [String] YAML representation of the config
    def self.to_yaml
      to_hash.to_yaml
    end

    # Load the Tenant#frontend_config from MnoHub and add it to the settings
    #
    #  TODO: include retry/caching/...
    def self.load_config!
      return unless (frontend_config = fetch_tenant_config)

      # Merge the settings and reload
      Settings.add_source!(frontend_config)
      Settings.reload!

      # Reconfigure mnoe
      reconfigure_mnoe!

      # TODO: update JSON_SCHEMA with readonly fields

      # # Save settings in YAML format for easy debugging
      # Rails.logger.debug "Settings loaded -> Saving..."
      # File.open(Rails.root.join('tmp', 'cache', 'settings.yml'), 'w') do |f|
      #   f.write(Settings.to_hash.deep_stringify_keys.to_yaml)
      # end
    end

    # Reconfigure Mnoe settings that were set during initialization
    def self.reconfigure_mnoe!
      MnoEnterprise.configure do |config|
        config.app_name = Settings.system.app_name

        # Emailing
        config.support_email = Settings.system.email.support_email
        config.default_sender_name = Settings.system.email.default_sender.name
        config.default_sender_email = Settings.system.email.default_sender.email

        # I18n
        config.i18n_enabled = Settings.system.i18n.enabled
      end
      Rails.application.config.action_mailer.smtp_settings = Settings.system.smtp
    end

    # Fetch the Tenant#frontend_config from MnoHub
    #
    # @return [Hash] Tenant configuration
    def self.fetch_tenant_config
      MnoEnterprise::Tenant.show.frontend_config
    rescue JsonApiClient::Errors::ConnectionError
      Rails.logger.warn "Couldn't get configuration from MnoHub"
      puts "Couldn't get configuration from MnoHub"
    end

    # Convert JSON Schema to hash with default value
    #
    # @param [Hash] schema JSON schema to parse
    def self.build_object(schema)
      case schema['type']
      when 'string', 'integer', 'boolean'
        schema['default']
      when 'object'
        h = {}
        schema['properties'].each do |k, inner_schema|
          h[k] = build_object(inner_schema)
        end
        h.compact
      end
    end
  end
end
