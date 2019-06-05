import groovy.json.JsonSlurper //put your imports here
pipeline {
          agent any
          options {
                    timeout(time: 1, unit: 'HOURS')          
                  }
          environment {
                       PATH = "$PATH:/usr/local/bin" //adding Erlang path
                      } 
          parameters {
                      string(name: 'SAP_HOST', defaultValue: '35.174.22.86', description: 'Enter the SAP Host IP address or FQDN')
                      string(name: 'SAP_PORT', defaultValue: '8000', description: 'Enter the SAP Host port number')
                      string(name: 'SAP_CLIENT', defaultValue: '001', description: 'Enter the SAP client number')
                      string(name: 'PROTOCOL', defaultValue: 'http', description: 'http or https')
                      string(name: 'OBJECT', defaultValue: '\$SIMPLE_CALCULATOR', description: 'Enter the Object Name')
                      //booleanParam(name: 'COVERAGE', defaultValue: false, description: 'Toggle this value for coverage option')
                      choice(name: 'TYPE', choices: ['package', 'class', 'program'], description: 'Select Object Type option')
                      choice(name: 'COVERAGE', choices: ['false', 'true'], description: 'Select coverage option')
                      //password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password (sample option)')
                      //file(name: "FILE", description: "Choose a file to upload (sample option)")
                     }
          stages {
                  stage('Preparation Erlang Tools') {
                  steps { 
                     checkout changelog: false, poll: false, scm: [$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'my_token', url: 'https://innersource.accenture.com/scm/radiostar/devops-abap.git']]]
                        }  
                  }
                  stage('ABAP Unit Test') {
                   when {
                        expression { params.COVERAGE == 'false' }
                       }   
                  steps {
                      sh 'printenv'
                      sh 'whoami'
                      echo "Client Id is ${params.SAP_CLIENT}"
                      echo "Object is ${params.OBJECT}"
                      echo 'test'
                      sh 'pwd'
                      echo "PATH is $PATH"
                      sh 'which erl'
                      sh 'erl -version'
                      sh 'which escript'
                      sh 'ls -lrta'
                      withCredentials([usernamePassword(credentialsId: 'NPL', passwordVariable: 'SAP_PASSWORD', usernameVariable: 'SAP_USER')]) {
                       sh "/usr/local/bin/escript sap_abap_unit_test ${SAP_HOST} ${SAP_PORT} ${PROTOCOL} ${SAP_CLIENT} ${SAP_USER} ${SAP_PASSWORD} ${TYPE} '$SIMPLE_CALCULATOR' ${COVERAGE}"
                      }
                      //sh './aunit-junit-parser aunit-junit.xsl return_aunit.xml > test-results/return-aunit-result.xml'
                      sh 'ls -lrta test-results'
                      //sh 'cat test-results/return-aunit-result.xml'
                      
                  } // end steps clause
                } // end stage clause
  
                  stage('ABAP Unit Test with Coverage') {
                  when {
                        expression { params.COVERAGE == 'true' }
                       }  
                        /* input {
                        message "Should we continue?"
                        ok "Yes, we should."
                        submitter "jenkins,veneraldo"
                         parameters {
                        string(name: 'CSRF', defaultValue: 'Mr Apelo', description: 'What is the CSRF?')
                                  }
                       } */
                  steps {
                      echo 'ABAP Unit Test with Coverage'
                      sh 'printenv'
                      sh 'whoami'
                      echo "Client Id is ${params.SAP_CLIENT}"
                      echo "Object is ${params.OBJECT}"
                      echo 'test'
                      sh 'pwd'
                      echo "PATH is $PATH"
                      sh 'which erl'
                      sh 'erl -version'
                      sh 'which escript'
                      sh 'ls -lrta'
                      withCredentials([usernamePassword(credentialsId: 'NPL', passwordVariable: 'SAP_PASSWORD', usernameVariable: 'SAP_USER')]) {
                       sh "/usr/local/bin/escript sap_abap_unit_test ${SAP_HOST} ${SAP_PORT} ${PROTOCOL} ${SAP_CLIENT} ${SAP_USER} ${SAP_PASSWORD} ${TYPE} ${OBJECT} ${COVERAGE}"
                      }
                     } // end steps clause
                  } // end stage clause
              
                  stage('ABAP Test Cockpit (ATC)') {
                  steps {
                      withCredentials([usernamePassword(credentialsId: 'NPL', passwordVariable: 'SAP_PASSWORD', usernameVariable: 'SAP_USER')]) {
                       sh "/usr/local/bin/escript sap_abap_atc ${SAP_HOST} ${SAP_PORT} ${PROTOCOL} ${SAP_CLIENT} ${SAP_USER} ${SAP_PASSWORD} ${TYPE} ${OBJECT} ${COVERAGE}"
                      }
                      
                  } // end steps clause
                } // end stage clause
  
          } // end stages clause
          post { 
               always { 
                      echo 'Publishing JUnitresults!'
                      //sh './aunit-junit-parser aunit-junit.xsl aunit_failed_sample.xml > test-results/junit-test-result.xml'
                      sh 'ls -lrta'
                      //step([$class: 'JUnitResultArchiver', allowEmptyResults: true, keepLongStdio: true, testResults: 'test-results/*.xml']) 
                      step([$class: 'JUnitResultArchiver', testResults: 'test-results/*.xml'])
                      cleanWs()
                      }
               }    
    }
