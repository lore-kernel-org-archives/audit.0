Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BAD211491
	for <audit@vger.kernel.org>; Tue, 14 Oct 2025 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445813; cv=none; b=FtaVZXWBQ9bVWUqWFYt46CKO4VF7IqT3AiPFwJgcvVSBarx9xwaV0eqCDuH+rbnHrs/hPkkNSfnxjKVElpwtdJCk3qyV3xQGCAThVfpXXsbe+pRykyZyNXkw25N83A+DjCL3OGy0Y1auN2LTCiK+WhaQtoSINo3qL9aFWYA4WPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445813; c=relaxed/simple;
	bh=ZUn+2bWdty+sk/iuCeUPHo8jGo8fRJ7TPvwZ9XUUXDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+PYmmQPQfjNBsXHMutmg5DdkcGv2SeAkO+o//KHMPz4G4nCyO5rT7i4cw67WvWUql3FcDOs4MDmXRuhWA7NbSk721GEhb1oYzDHpCEVFxpJRDLPFFzTZA5nXyX2V6EUQdUrVUYjfRtKrzRNju8GowG7jstsMvLMD4yrbK521EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aHbTwLW6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHbTwLW6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760445810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Lqhwwhq3/j9K14UcUbnvxwFr5CkuzbyydsVhsDSBRk=;
	b=aHbTwLW6f8Wq2D4/1dZr5XPMcBrQ0QLqZxVy6sodypvr5++HoBm+/gMKgU9h0+iAzhVDFl
	M+C4lASgvHmKMOxHOL5JiqKbxB2ISqC2ArkK2EHyxpflqRiPkh455DmE22fLZcAlnDTIcK
	pNhlX8wcyEs4B4Hhm4e+ZG1o33NV4kw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-58KWw4WUPZ28ouyjLvfq9A-1; Tue, 14 Oct 2025 08:43:29 -0400
X-MC-Unique: 58KWw4WUPZ28ouyjLvfq9A-1
X-Mimecast-MFC-AGG-ID: 58KWw4WUPZ28ouyjLvfq9A_1760445808
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afcb72a8816so494016066b.0
        for <audit@vger.kernel.org>; Tue, 14 Oct 2025 05:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445808; x=1761050608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Lqhwwhq3/j9K14UcUbnvxwFr5CkuzbyydsVhsDSBRk=;
        b=e9772GoF2BqTiYxigpJMtpJLzh111J5swNohV0X1QViptBm0LyrhrJrU69sc8Wai//
         xMm7fucsws37rxDPW8CrpDXTXj/J51lTPUFWgo8ZjQKyNAkP3V8OkccRJiZzDfPDAA1m
         8Yj5q6YmmoEDBckZgDPxvd9iQkgtEDSa55L2prZnh4IlDUhKFa63S5dAb7iNXdCV5Dcn
         ufeowkY6QQxz7hdCJcHBw9C7/kUZc7YPzdzeMlDHnyncz+/w03Dy40e9J5nw58zbweA6
         XsuB5wYGaA54RKg4XHoCZ2veh4lYeIM/ZGslFJ04T7rz4m+UQe4EzCjizPVKE9E//oTB
         unjg==
X-Gm-Message-State: AOJu0YxHRVAHmI2uAPeednoWBdP8WDAMngaspDwhhz93LBSCr2Kly1E+
	TG59/8CJB5/z2yMKQNUqS8ZVQS5RhMaeV3SDZYNFYhclFnckDRoHdeADtZ2qeaQcGIMt+ivSdmf
	Nc4Hd+rsvEg9FZo19A7pNThWOtgZ6ORUv/F763BsYZEPsdlY/L1yI5euHH9atPmtL6t+rxh9h/J
	OijYdZVCwGvPoJ0D2MNLstD1AX0DxKCkQ=
X-Gm-Gg: ASbGncuIa2KschFl1Pb6YDgG5uXBv+PPNbn97cAGxbhSiXZaRUqRkbKuZH5//R24abO
	wzc0ODFe4r8SXInBTdR7uWehJfbxJVPyvpoXgdY34adornQGTmvBA6wApjprMqU1uSzhiJn3dNS
	356SuA9c635FGwkEbDyzvr3p6HVnyipNSubjbG1QgBDY8B1Ln46boP0A==
X-Received: by 2002:a17:907:97d0:b0:b4a:e11a:195b with SMTP id a640c23a62f3a-b50ac7e7627mr2504119166b.44.1760445808205;
        Tue, 14 Oct 2025 05:43:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSOYeH80eICglV/QLHQmccRFIhSJtB9RJNZf1ns4OKzLqeItz2Pn1wEW8TT69CHUuGe3Of3Lvcfom53E3YGbs=
X-Received: by 2002:a17:907:97d0:b0:b4a:e11a:195b with SMTP id
 a640c23a62f3a-b50ac7e7627mr2504116066b.44.1760445807807; Tue, 14 Oct 2025
 05:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008142719.2564034-1-rrobaina@redhat.com> <586cc14d04810b3154d2eda25d6b06a0@paul-moore.com>
In-Reply-To: <586cc14d04810b3154d2eda25d6b06a0@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 14 Oct 2025 09:43:16 -0300
X-Gm-Features: AS18NWBbH9qWWVQFJlWNtDYR_M3fvvQJG36MZGpSfchBzkBRKgSoycEVXK-Wn2M
Message-ID: <CAABTaaB09=GzphmyNkHQq2S+q4dUbVa4jFpMB=JgEY5f-BLBHQ@mail.gmail.com>
Subject: Re: [PATCH] audit: fix comment misindentation in audit.h
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZM3Mny7zA04M7jnwBt5i7CfNgS59hvIfZaMFqFivf3k_1760445808
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Oct  8, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > Minor comment misindentation adjustment.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  kernel/audit.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Merged into audit/dev, thanks.
>
> --
> paul-moore.com
>

Thanks, Paul!

