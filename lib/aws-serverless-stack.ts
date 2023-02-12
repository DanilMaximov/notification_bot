import { Stack, StackProps } from 'aws-cdk-lib';
import { Construct } from 'constructs';
import { Functions } from './resources'
import * as dotenv from 'dotenv';

dotenv.config();
export class AwsServerlessStack extends Stack {
  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props);

    new Functions(this, 'Functions', {
      tgSecret: process.env.TELEGRAM_SECRET as string, 
      region: process.env.REGION as string
    });
  }
}
