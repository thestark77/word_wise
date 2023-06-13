import {
  IonAccordion,
  IonAccordionGroup,
  IonButton,
  IonCol,
  IonContent,
  IonFooter,
  IonGrid,
  IonHeader,
  IonIcon,
  IonItem,
  IonLabel,
  IonMenu,
  IonRow,
  IonSelect,
  IonSelectOption,
  IonTitle,
  IonToolbar
} from '@ionic/react'
import { homeSharp } from 'ionicons/icons'
import image from '../../assets/img/logo.svg'
import { pestanasAplicacion } from '../../interfaces'
import './Menu.css'
// ;<IonMenuToggle key={index} autoHide={false}>
//   <IonItem
//     className={
//       location.pathname === appPage.url
//         ? 'selected ion-margin-vertical'
//         : 'ion-margin-vertical'
//     }
//     routerLink={appPage.url}
//     routerDirection='none'
//     lines='none'
//     detail={false}
//   >
//     <IonIcon slot='start' ios={appPage.iosIcon} md={appPage.mdIcon} />
//     <IonLabel>{appPage.titulo}</IonLabel>
//   </IonItem>
// </IonMenuToggle>

const Menu: React.FC = () => {
  return (
    <IonMenu disabled={false} contentId='main' type='overlay'>
      <IonHeader>
        <IonToolbar>
          <IonGrid>
            <IonCol>
              <IonRow>
                {
                  <div className='image'>
                    <img src={image} alt='avatar' />
                  </div>
                }
              </IonRow>
            </IonCol>
          </IonGrid>
        </IonToolbar>
      </IonHeader>

      <IonContent className='no-scroll'>
        <IonGrid>
          <IonRow>
            <IonCol>
              <IonTitle style={{ fontSize: '1.5rem' }} color='primary'>
                Programa académico
              </IonTitle>
              <IonItem lines='full'>
                <IonSelect
                  placeholder='Selecciona tu programa'
                  justify='start'
                  interface='popover'
                >
                  <IonSelectOption value='brown'>
                    Ingeniería de Sistemas
                  </IonSelectOption>
                  <IonSelectOption value='blonde'>
                    Ingeniería industrial
                  </IonSelectOption>
                  <IonSelectOption value='red'>
                    Licenciatura en Bilingüismo
                  </IonSelectOption>
                </IonSelect>
              </IonItem>
            </IonCol>
          </IonRow>

          <IonRow>
            <IonCol className='margenVertical'>
              <IonItem
                className='inicio'
                color='light'
                lines='none'
                detail={false}
              >
                <IonIcon slot='start' ios={homeSharp} md={homeSharp} />
                <IonLabel>Inicio</IonLabel>
              </IonItem>
            </IonCol>
          </IonRow>
          <IonRow>
            <IonCol>
              <IonAccordionGroup multiple={true}>
                {pestanasAplicacion.map((pagina, index) => {
                  return (
                    <IonAccordion
                      key={index}
                      className='accordion margenVertical'
                    >
                      <IonItem
                        slot='header'
                        color='light'
                        lines='none'
                        detail={false}
                      >
                        <IonIcon
                          slot='start'
                          ios={pagina.iosIcon}
                          md={pagina.mdIcon}
                        />
                        <IonLabel>{pagina.titulo}</IonLabel>
                      </IonItem>
                      {pagina.subpaneles.map((subpanel, index) => {
                        return (
                          <IonItem
                            key={index}
                            className='ion-margin'
                            slot='content'
                            lines='full'
                            // onClick={}
                          >
                            <IonLabel>{subpanel}</IonLabel>
                          </IonItem>
                        )
                      })}
                    </IonAccordion>
                  )
                })}
              </IonAccordionGroup>
            </IonCol>
          </IonRow>
          <IonRow class='logout'>
            <IonCol>
              <IonButton className='button' expand='block'>
                Cerrar sesión
              </IonButton>
            </IonCol>
          </IonRow>
        </IonGrid>
      </IonContent>
      <IonFooter className='ion-text-center'>
        <IonTitle color='secondary'>Word Wise</IonTitle>
      </IonFooter>
    </IonMenu>
  )
}

export default Menu
