Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A9F8BE1
	for <audit@vger.kernel.org>; Mon, 13 Nov 2023 03:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fkCBvdwp"
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C67D1
	for <audit@vger.kernel.org>; Sun, 12 Nov 2023 19:36:36 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso3877764276.2
        for <audit@vger.kernel.org>; Sun, 12 Nov 2023 19:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699846595; x=1700451395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GJmOyC7dj1ImgyOrqYv2p5YXSbSzd12oTHJ212zpro=;
        b=fkCBvdwpCUxKRum/myqn9PoWW3gHgAF07k/Z5s+14Eo32OZbBxHW/CwHaHED/5sbMw
         u1sJUAP/4+w9jtaYLixyXwdNMymejr5BgzGKGCM8k/e15V6h0MSXEInFruAGpLQeJl5u
         A1NlRuFd4MMcufwUiEoYLP6XH5QRPNu51LkR3d/DQZTqOzStFqsaeB5vJfLODESTOOM2
         uOgAlY+oNvQuXSt0MjwH4rLmeQGhYWU/m6ASpyUAgvcZX9OhxY6l8zHClCriQ9pIH1DS
         nsk5HYrfFyqEdLLG4TwAYKS/VlzPF11wfzZGmWYBEVOVWvnv52PobHIgns6coOHlyX6D
         fg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699846595; x=1700451395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GJmOyC7dj1ImgyOrqYv2p5YXSbSzd12oTHJ212zpro=;
        b=GvJw61h5AKne8em0ZUD/haT5RO9Ko+9nBy2t9NjirSA9lHWaUQqXvkkJHZHV5wxn+C
         M7dv7ALJkDckngf7ASCNFR72aExHOHNOMMHKrwxZMaseTLSwSRN0AqrKBBUERRudwmOO
         5LDugWfywbRYIlcBpYSZRKOsBeImk4yxbKA0ZtdYgxObBTepiM6GQcx4xSSdsjlWWBu4
         qDugMidcR+lGrjVxAoL6jo7887e9zHt5qtR0y+kebW6dQ4zcVwAZW1903pkkhmZFx9d4
         +dv411ffP7/GQllWUt6HVvjhMyoTZN9qJGDwblCRz5n6xsReqUL1hS5U6Wcn1SzCfbwL
         w51A==
X-Gm-Message-State: AOJu0Yzgj/4ObN/hNggnVCKe1jzdle15ZOXmhAbLV2bn4/d5Nvmu/7n3
	wFAlizA7tkUhx2QSR4hV9mrlPohz6MWXKnr3TX6DYcmpfmOyA18=
X-Google-Smtp-Source: AGHT+IHHTmKxnEkC0RC2JDbWYjvkSSGIvuWoFDdAwa+RNPCR7iXTCqXKnmOhpLla/t8T9O2ppI2jdTf+GCVFtddvLQw=
X-Received: by 2002:a25:3489:0:b0:da1:2a2b:4c5b with SMTP id
 b131-20020a253489000000b00da12a2b4c5bmr4277026yba.41.1699846595296; Sun, 12
 Nov 2023 19:36:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018092351.195715-1-chris.riches@nutanix.com> <c5f6bd1dee4ad9b43fc8c9dc1c7645b3.paul@paul-moore.com>
In-Reply-To: <c5f6bd1dee4ad9b43fc8c9dc1c7645b3.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 12 Nov 2023 22:36:24 -0500
Message-ID: <CAHC9VhQryMhepfZwoVmb6Svs7uq9vJ-oa0S7Lc6v7jyhiGvm_g@mail.gmail.com>
Subject: Re: [PATCH v2] audit: Send netlink ACK before setting connection in auditd_set
To: Chris Riches <chris.riches@nutanix.com>
Cc: audit@vger.kernel.org, Eric Paris <eparis@redhat.com>, jonathan.davies@nutanix.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 6:31=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Oct 18, 2023 Paul Moore <paul@paul-moore.com> wrote:
> >
> > When auditd_set sets the auditd_conn pointer, audit messages can
> > immediately be put on the socket by other kernel threads. If the backlo=
g
> > is large or the rate is high, this can immediately fill the socket
> > buffer. If the audit daemon requested an ACK for this operation, a full
> > socket buffer causes the ACK to get dropped, also setting ENOBUFS on th=
e
> > socket.
> >
> > To avoid this race and ensure ACKs get through, fast-track the ACK in
> > this specific case to ensure it is sent before auditd_conn is set.
> >
> > Signed-off-by: Chris Riches <chris.riches@nutanix.com>
> > ---
> >
> > > I'm happier with the bool over the integer type for the @ack variable=
.
> > > I'd suggest updating the patch and posting it again so we can review
> > > it in full, but we weren't very far off last time so I think it shoul=
d
> > > be close, if not acceptable on the next revision.
> >
> > Here's the latest iteration of the suggested patch. I've done it via gi=
t
> > send-email so it should apply cleanly.
> >
> >  kernel/audit.c | 31 ++++++++++++++++++++++++-------
> >  1 file changed, 24 insertions(+), 7 deletions(-)
>
> This looks good to me, thanks for your patience and persistence Chris.
>
> I'm going to merge this into audit/dev-staging now and it will move to
> audit/dev once v6.7-rc1 is released and the merge window closes.

I've now merged this into lsm/dev, thanks again Chris.

--=20
paul-moore.com
