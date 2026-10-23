Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759536;
	b=tEjvlm12y5ipnkhFSjfpgz49TFiC7ps9xvU/Z6QTpGNYD55M59zHDPjCICgzTlqiSNks
	 mx2aAvSyZ9de0Fcf/NgAYTnksWd+90daGaoWLv1tRACtmhxJ6LLuoVAHSX9ECH9SqmO6k
	 prPnC4JBFl2RLZXI3E+WP8zbZfWc/grzYkabrsjW6RkC8bj+WKlbAwUc6trfnw9yMcLeO
	 38Jomcft22sNnNDVghxcNwxgiktu0LZ5W4hzR7c/ee+dl1BuxSAencukf+O/8qrD9lM8F
	 gomUBVsVpvxgc81K8iTNTYKHMofw9OI54OajX8CB1et2kjkMdOESiLg6muzAHoPkh5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759536;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
	b=HlDMximYRopQ0qUlqLJraDXCx4kFzqYDyOXOiSwNbJNWMXIJIN266/tXqT13lP3gJinV
	 5cpjPk5Sc2nNlUyl9sw4QD8nnN20KipKZu8nke45jeiy40gv+awlG/WPRYKEp6rrYHaWQ
	 trWauwLPovO2ZohIQqGHmMijYmzuEhiqyF52MbRtrit0Fylme3zUPBeP1xNG6J58T4ivy
	 /53dKyJKaxiZR/ow1f/mK2gQgSjuza311Mcr9EM57+liMqJgt+qpErudkptCep6NbC0dE
	 8SKyEtKDMUpNyCyakcbBG/QVEOjTMMwNwcmKY0aLgyshUNkZ9rIoYhuvQa6b9K95luQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JFCilMtk;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55CB606A322
	for <audit@vger.kernel.org>; Fri, 23 Oct 2026 12:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C55CB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JFCilMtk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792759534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
	b=JFCilMtkUblpG0se/OsDP8XQNcS0g5CbxN4al/yDpGmYxsKAuaBflAG9Ot1vUdjN4LK9kx
	6KihEPKO+lHEjYmLhUHLQBXjHW8sH5zxS6puIxjSFzPEXhebnff8clkn5/qJZVNpLCKzd4
	ANALi0his2JyaJHN1lr2Y9JnHEvtemw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-bggk0TBPPw2xSSb6Z7OwKA-1; Fri, 23 Oct 2026 08:45:33 -0400
X-MC-Unique: bggk0TBPPw2xSSb6Z7OwKA-1
X-Mimecast-MFC-AGG-ID: bggk0TBPPw2xSSb6Z7OwKA_1792759532
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c42394d1e41so70590166b.3
        for <audit@vger.kernel.org>; Fri, 23 Oct 2026 05:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792759532; x=1793364332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
        b=Ne+JVWvCkLEgfADshz2DpzTLuuKPq3zxWsZVo9AijwVGdrMRWcd8FjwtKNMu+4YMHJ
         hDHnRExh+LkbzMeN4KoH/EPvvvUvaZEp1Zj+0U6zF6iIyQDNNX6g4WzJwOfj74cG7Bq8
         mcG8zcaHzDB6xlh7MXnkbR2RhIGH6j6tjPRZj2vro2OIFG87hihSVzAe31jfRC9SrnCF
         Kg0BeUMdia5uG51wdP4/HP28FJDwemAROjzgBFLtY1QyQIvMprAJOFtrlO/D5wisZNZZ
         5VSSGYKGdj7GeAi+8cdaox7h3Kg7zv9LNnGluWUDrCJ0iv1sQAf38EwyyQqTSB9IDLgD
         ySbQ==
X-Gm-Message-State: AFq9FYIykCozmD7gQ5JJQlocVj6ZbDLKt1+KtV7rRArJ9nWfdnMZCjI8
	HHa7Jobnzdin4A2IUrSWk/YvoRTpsuXI01gh1yRnf5ZCf7xov1+xQHlXL5bcIelnnvq2CT7VVt8
	H0AuC5ETn0DTv/lwIfBKBInevNQAfaCV6Ta2WPzPLpMbf2lIKAetDZs7qwyvmdLgNeIOWk8yVTI
	3oq3Wesk9j8V/rTOH++zQ6oL7jMI5T6TY=
X-Gm-Gg: AYBFou31dx66jTbmct+QsroG69J+eCPccB92hLIa4a0uTOqj39qTMZPYfkwC0DeuWC2
	N40ZcxPXBfBSZOSXaKm7+v0jY68tH/ZqzZncu9fKI/hewXcahDJF8y8nJ+5qwInEjz7zjKXPMpR
	OeZriWHAbHj9B3YqPrKQqo2uMfYplYfKbPB3HBKl6UAqo+0JkeSYS+JbzluvIoUHpFrBitp51q+
	7BJ68Z82pw518HCjCsmpPW7jhGjcMo9ZVRzGi2GbELXWd6vClHM0PMosOJ8J5X8DakAtgpC9VCs
	SKA=
X-Received: by 2002:a17:907:fd8a:b0:c2e:46d0:b802 with SMTP id a640c23a62f3a-c46a92ae6c0mr328360166b.40.1792759531935;
        Fri, 23 Oct 2026 05:45:31 -0700 (PDT)
X-Received: by 2002:a17:907:fd8a:b0:c2e:46d0:b802 with SMTP id
 a640c23a62f3a-c46a92ae6c0mr328354266b.40.1792759531460; Fri, 23 Oct 2026
 05:45:31 -0700 (PDT)
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com> <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
In-Reply-To: <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 23 Oct 2026 09:45:20 -0300
X-Gm-Features: AclHuK-AKUESe6iHVc-VzwOYib6sgRKlK0BCnAtM6wg5S60Ozyo0oOLLHvDr8CI
Message-ID: <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s2VWf9oDu32svlRIHq2uIcYulmsmA_uiRoEGi31thYE_1792759532
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 1:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> > On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@red=
hat.com> wrote:
>
> ...
>
> > > * As pointed out by Sashiko, when you were converting all of the
> > > arches, it looks like you missed alpha.  I took a quick look and it
> > > appears that it should be a pretty straightforward conversion like
> > > most of the others.
> >
> > I've actually dropped the alpha patch as per Magnus's request [1].
> >
> > [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBK=
y4BLWOvDTt92t5Eg@mail.gmail.com/
>
> The problem is that as things stand, this patchset breaks the build on
> Alpha.  Perhaps this gets resolved during the current merge window,
> but as you know we can't break the kernel build ...
>
> https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.com

Of course, you're absolutely right that we can't break the build. I
was afraid that this dependency might cause trouble.

I noticed Magnus posted a pull request a few days ago containing the
"alpha: enable GENERIC_ENTRY" series [1]. It seems this will get
resolved during the current merge window.

For future reference, what's the best way to handle dependencies on
other subsystem changes like this?

[1] https://lore.kernel.org/linux-alpha/ataJlL6L7TrS3gWs@z440.darklands.se/

>
> --
> paul-moore.com
>

-Ricardo

