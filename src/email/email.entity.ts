import { Entity, PrimaryGeneratedColumn } from 'typeorm';
@Entity()
export class Email {
  @PrimaryGeneratedColumn()
  id: number;
}
