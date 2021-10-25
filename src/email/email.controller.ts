import { Controller } from '@nestjs/common';
import { Crud, CrudController } from '@nestjsx/crud';
import { Email } from './email.entity';
import { EmailService } from './email.service';

@Crud({
  model: {
    type: Email,
  },
})
@Controller('email')
export class EmailController implements CrudController<Email> {
  constructor(public service: EmailService) {}
}
