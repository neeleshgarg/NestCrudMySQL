#!/usr/bin/bash  

echo "Enter the module name: "  
read moduleName 
nest g mo $moduleName --no-spec
nest g co $moduleName --no-spec
nest g s $moduleName --no-spec


entityLC=${moduleName,,}
entityUC=${moduleName^}

service=${entityUC}Service
controller=${entityUC}Controller
module=${entityUC}Module

touch ./src/$entityLC/$entityLC.entity.ts
sudo tee -a ./src/$entityLC/$entityLC.entity.ts >> /dev/null <<EOT
import { Entity, PrimaryGeneratedColumn } from 'typeorm';
@Entity()
export class $entityUC {
  @PrimaryGeneratedColumn()
  id: number;
}
EOT

truncate -s 0 ./src/$entityLC/$entityLC.service.ts
sudo tee -a ./src/$entityLC/$entityLC.service.ts >> /dev/null <<EOT
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { $entityUC } from './$entityLC.entity';

@Injectable()
export class $service extends TypeOrmCrudService<$entityUC> {
  constructor(@InjectRepository($entityUC) repo) {
    super(repo);
  }
}
EOT

truncate -s 0 ./src/$entityLC/$entityLC.controller.ts
sudo tee -a ./src/$entityLC/$entityLC.controller.ts >> /dev/null <<EOT
import { Controller } from '@nestjs/common';
import { Crud, CrudController } from '@nestjsx/crud';
import { $entityUC } from './$entityLC.entity';
import { $service } from './$entityLC.service';

@Crud({
  model: {
    type: $entityUC,
  },
})
@Controller('$entityLC')
export class $controller implements CrudController<$entityUC> {
  constructor(public service: $service) {}
}
EOT

truncate -s 0 ./src/$entityLC/$entityLC.module.ts
sudo tee -a ./src/$entityLC/$entityLC.module.ts >> /dev/null <<EOT
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { $entityUC } from './$entityLC.entity';
import { $controller } from './$entityLC.controller';
import { $service } from './$entityLC.service';

@Module({
  imports: [TypeOrmModule.forFeature([$entityUC])],
  controllers: [$controller],
  providers: [$service],
})
export class $module {}
EOT

echo "Module created successfully"
echo "Import entity name to entity file in entity folder"