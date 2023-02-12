import { Duration } from "aws-cdk-lib";
import { Code, Runtime, Function, IFunction } from "aws-cdk-lib/aws-lambda";
import { Construct } from "constructs";
import { RetentionDays } from "aws-cdk-lib/aws-logs";
import { join } from "path";

interface FunctionsProps {
  tgSecret: string;
  region: string;
}

export type ApplicationFunctions = {
  BotClientFunction: IFunction
}

export default class Functions extends Construct {
  readonly BotClientFunction: Function;

  constructor(scope: Construct, id: string, props: FunctionsProps){
    super(scope, id);    

    this.BotClientFunction = this.createBotClientFunction(props.tgSecret, props.region);
  }

  public all = (): ApplicationFunctions => ({ 
    BotClientFunction: this.BotClientFunction
  });

  private createBotClientFunction(tgSecret: string, region: string) : Function {
    const BotClientFunctionProps = {
      code: Code.fromAsset(join(__dirname, `/../../src/client/vendor`)),
      handler: 'source.BotClient::Application.process',
      runtime: Runtime.RUBY_2_7,
      timeout: Duration.seconds(60),
      logRetention: RetentionDays.ONE_WEEK,
      retryAttempts: 0,./app/interactors/signoff_update/walkthrough.rb:14
      environment: {
        TELEGRAM_BOT_TOKEN: tgSecret as string, 
        REGION: region as string
      }
    }

    return new Function(this, 'BotClientFunction', BotClientFunctionProps);
  }
}