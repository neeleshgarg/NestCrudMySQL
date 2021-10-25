import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { Email } from './email.entity';

@Injectable()
export class EmailService extends TypeOrmCrudService<Email> {
  constructor(@InjectRepository(Email) repo) {
    super(repo);
  }
}
